//
//  CareerService.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 28/04/2020.
//  Copyright © 2020 Marlabs Inc. All rights reserved.
//

import Foundation
import MapKit

class CareerService: NSObject {
    let limit: Int = 20
    var offset: Int = 0
    var totalCount: Int = -1
    var shouldRealodList: Bool = false
    var didReachEndOfList: Bool {
        return (totalCount != -1 && offset > totalCount)
    }

    static let shared = CareerService()

    // restricting the init usage outside the class
    private override init() {}

    /// All Careers items will be fetched
    /// This method is to fetch array of careers from the server
    /// - Parameters:
    /// - Parameter loadMore: whether to load more items
    func fetchListOfCareers(loadMore: Bool? = false,
                             completionHandler: ((_ colleges: [Career]?, Error?) -> Void)? = nil) {

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

            let params = ["offset": String(self.offset),
                          "limit": String(self.limit)]

            let api = APIRequest(api: .careers, params: params)
            api.invoke { result, error, _ in
                var colleges: [Career]?
                var errorReturns: Error?
                var errorCode: Int?
                if error == nil {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let careerResponse = try jsonDecoder.decode(CareerResponse.self, from: result as? Data ?? Data())
                        self.totalCount = careerResponse.count ?? -1
                        colleges = careerResponse.results
                    } catch {
                        let message = "Unable to parse the response obtained from the Careers API"
                        errorCode = 5019
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
    func fetchCareerLogo(tile: Career, completionHandler: ((Career?, Error?) -> Void)? = nil) {
        if let imagePath = tile.logo {
            var parseError: Error?
            let fileManager = FileManager.default

            let imageComponentArray: Array = imagePath.split(separator: Character.init("/"))

            let newImageName = imageComponentArray[imageComponentArray.count - 1 ]

           print("newImageName:", newImageName)

            let imageName = imagePath.suffix(imagePath.count - 7)

            print("imageName:", imageName)

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

    /// This method is to fetch career details based on careerid(career_uid).
    /// - Parameter career_uid: career id
    /// - Parameter completionHandler: If success returns  career details, else returns error
    func fetchCareerDetails(careerID: String?, completionHandler: ((CareerDetails?, Error?) -> Void)? = nil) {
        let api = APIRequest(api: .careers, pathComp: careerID)
        api.invoke { result, error, _ in
            var careerDetails: CareerDetails?
            var errorReturns: Error?
            var errorCode: Int?
            if error == nil {
                do {
                    let jsonDecoder = JSONDecoder()
                    careerDetails = try jsonDecoder.decode(CareerDetails.self, from: result as? Data ?? Data())
                } catch {
                    let message = "Unable to parse the response obtained from the Career details API"
                    errorCode = 5014
                    errorReturns = NSError(domain: message,
                                           code: errorCode!,
                                           userInfo: nil)
                }
            } else {
                errorReturns = error
            }
            if completionHandler != nil {
                completionHandler!(careerDetails, errorReturns)
            }
        }
    }

}
