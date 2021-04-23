//
//  NCCollegeService.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 07/12/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation
import MapKit

class NCCollegeService: NSObject {
    let limit: Int = 20
    var offset: Int = 0
    var totalCount: Int = -1
    var shouldRealodList: Bool = false
    var didReachEndOfList: Bool {
        return (totalCount != -1 && offset > totalCount)
    }

    var stateType: String = FilterConstants.stateTypeIn {
        didSet {
            shouldRealodList = true
        }
    }

    var satScore: MinMax = MinMax(min: FilterConstants.satScoreMinimum, max: FilterConstants.satScoreMaximum) {
        didSet {
            shouldRealodList = true
        }
    }

    var actScore: MinMax = MinMax(min: FilterConstants.actScoreMinimum, max: FilterConstants.actScoreMaximum) {
        didSet {
            shouldRealodList = true
        }
    }

    var majors: [Major]? {
        didSet {
            shouldRealodList = true
        }
    }

    var studentCapacity: MinMax? {
        didSet {
            shouldRealodList = true
        }
    }

    var costPerYear: MinMax = MinMax(min: FilterConstants.costPerYearMinimum, max: FilterConstants.costPerYearMaximum) {
        didSet {
            shouldRealodList = true
        }
    }

    var searchKey: String? {
        didSet {
            shouldRealodList = true
        }
    }

    var isFilterApplied: Bool {
        return !(stateType == FilterConstants.stateTypeIn
            && satScore.min == FilterConstants.satScoreMinimum
            && satScore.max == FilterConstants.satScoreMaximum
            && actScore.min == FilterConstants.actScoreMinimum
            && actScore.max == FilterConstants.actScoreMaximum
            && majors == nil
            && studentCapacity == nil
            && costPerYear.min == FilterConstants.costPerYearMinimum
            && costPerYear.max == FilterConstants.costPerYearMaximum)
    }

    static let shared = NCCollegeService()

    // restricting the init usage outside the class
    private override init() {}

    /// All colleges will be fetched, if location data is nil.
    /// This method is to fetch array of colleges based on different parameters.
    /// - Parameters:
    /// - Parameter northEastCoordinate: Location data north east coordinate
    /// - Parameter southWestCoordinate: Location data south west coordinate
    /// - Parameter completionHandler:  If success returns  list of  colleges, else returns error
    func fetchListOfColleges(northEastCoordinate: CLLocationCoordinate2D? = nil,
                             southWestCoordinate: CLLocationCoordinate2D? = nil,
                             loadMore: Bool? = false, disabilityaccess: Bool? = false,
                             completionHandler: ((_ colleges: [College]?, Error?) -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            if self.shouldRealodList || loadMore == false {
                self.offset = 0
                self.totalCount = -1
                self.shouldRealodList = false
            } else {
                self.offset += self.limit
            }

            if self.didReachEndOfList &&
                completionHandler != nil {
                DispatchQueue.main.async {
                    completionHandler?(nil, nil)
                }
            }

            var filter: [String: Any] = [:]

            if self.searchKey != nil {
                filter["query"] = self.searchKey
            }

            if disabilityaccess ?? false {
                filter["disability_access"] = disabilityaccess
            } else {
                filter["state_type"] = self.stateType

                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                numberFormatter.roundingMode = .halfUp
                numberFormatter.maximumFractionDigits = 0
                numberFormatter.usesGroupingSeparator = false

                filter["sat_score_range"] = self.satScore.toDictionary(numberFormatter: numberFormatter)
                filter["act_score_range"] = self.actScore.toDictionary(numberFormatter: numberFormatter)
                filter["avg_cost_range"] = self.costPerYear.toDictionary(numberFormatter: numberFormatter)

                if self.studentCapacity != nil {
                    var studentCapacityDict = ["operator": self.studentCapacity?.operation.rawValue]
                    if let minStr = numberFormatter.string(for: self.studentCapacity?.min) {
                        studentCapacityDict["value1"] = minStr
                    }
                    if let maxStr = numberFormatter.string(for: self.studentCapacity?.max) {
                        studentCapacityDict["value2"] = maxStr
                    }
                    filter["student_capacity"] = studentCapacityDict
                }

                if let selectedMajors = self.majors?.map({ ($0.uid ?? "") }) {
                    filter["majors"] = selectedMajors
                }

                if let swCoordinate = southWestCoordinate,
                    let neCoordinate = northEastCoordinate {
                    filter["location_poly"] = ["lat1": String(neCoordinate.latitude),
                                               "lng1": String(neCoordinate.longitude),
                                               "lat2": String(swCoordinate.latitude),
                                               "lng2": String(swCoordinate.longitude)]
                }
            }

            let pagination = ["offset": String(self.offset),
                              "limit": String(self.limit)]

            let params = ["filter": filter,
                          "pagination": pagination]

            let api = APIRequest(api: .collegesList, params: params)
            api.invoke { result, error, _ in
                var colleges: [College]?
                var errorReturns: Error?
                var errorCode: Int?
                if error == nil {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let collegeResponse = try jsonDecoder.decode(CollegeReponse.self, from: result as? Data ?? Data())
                        self.totalCount = collegeResponse.count ?? -1
                        colleges = collegeResponse.results
                    } catch {
                        let message = "Unable to parse the response obtained from the Universities API"
                        errorCode = 5010
                        errorReturns = NSError(domain: message,
                                               code: errorCode!,
                                               userInfo: nil)
                    }
                } else {
                    errorReturns = error
                }
                DispatchQueue.main.async {
                    if completionHandler != nil {
                        completionHandler!(colleges, errorReturns)
                    }
                }
            }
        }
    }

    /// This method is to fetch item image  from the server
    /// - Parameter tile:item object
    /// - Parameter completionHandler: If success, returns tile, else error
    func fetchCollegeLogo(tile: College, completionHandler: ((College?, Error?) -> Void)? = nil) {
        if let imagePath = tile.logo {
            var parseError: Error?
            let fileManager = FileManager.default
            let imageName = imagePath.suffix(imagePath.count - 7)
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(String(imageName))
            print("path:", path)

            if fileManager.fileExists(atPath: path) {
                print("File exists. No API Call", path)
                tile.imageLocalFilePath = path

                if completionHandler != nil {
                    completionHandler!(tile, parseError)
                }

            } else {
                print("File doesn't exist.API Call", imagePath)
                let imageService = ImageService()
                imageService.fetchImage(path: String(imagePath)) { imageResponse, error in

                    if error == nil {
                        let imageData: Data = imageResponse as? Data ?? Data()

                        tile.imageLocalFilePath = imageData.saveAsImageInDocumentDirectory(path: String(imageName))
                    } else {
                        print("Unable to download image: ", error?.localizedDescription as Any)

                        let message = "Unable to download tile image from the location"
                        let errorCode = 5011
                        parseError = NSError(domain: message,
                                             code: errorCode,
                                             userInfo: nil)
                    }

                    if completionHandler != nil {
                        completionHandler!(tile, parseError)
                    }

                }

            }

        }
    }

    /// Method to fetch all majors from the API
    /// - Parameter completionHandler: If success returns  list of  majors, else returns error
    func fetchListOfMajors(completionHandler: (([Major]?, Error?) -> Void)? = nil) {
        let api = APIRequest(api: .majors, params: nil)
        api.invoke { result, error, _ in
            var majors: [Major]?
            var errorReturns: Error?
            var errorCode: Int?
            if error == nil {
                do {
                    let jsonDecoder = JSONDecoder()
                    majors = try jsonDecoder.decode([Major].self, from: result as? Data ?? Data())
                } catch {
                    let message = "Unable to parse the response obtained from the Majors API"
                    errorCode = 5011
                    errorReturns = NSError(domain: message,
                                           code: errorCode!,
                                           userInfo: nil)
                }
            } else {
                errorReturns = error
            }
            if completionHandler != nil {
                completionHandler!(majors, errorReturns)
            }
        }
    }

    /// This method is to fetch college details based on collegeid(university_uid).
    /// - Parameter university_uid: college id
    /// - Parameter completionHandler: If success returns  college details, else returns error
    func fetchCollegeDetails(universityID: String?, completionHandler: ((CollegeDetails?, Error?) -> Void)? = nil) {
        let api = APIRequest(api: .collegesDetails, pathComp: universityID)
        api.invoke { result, error, _ in
            var collegeDetails: CollegeDetails?
            var errorReturns: Error?
            var errorCode: Int?
            if error == nil {
                do {
                    let jsonDecoder = JSONDecoder()
                    collegeDetails = try jsonDecoder.decode(CollegeDetails.self, from: result as? Data ?? Data())
                } catch {
                    let message = "Unable to parse the response obtained from the University details API"
                    errorCode = 5012
                    errorReturns = NSError(domain: message,
                                           code: errorCode!,
                                           userInfo: nil)
                }
            } else {
                errorReturns = error
            }
            if completionHandler != nil {
                completionHandler!(collegeDetails, errorReturns)
            }
        }
    }
}
