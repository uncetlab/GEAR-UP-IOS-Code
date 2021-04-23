//
//  AnalyticsService.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 01/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation
import KeychainSwift

class AnalyticsService: NSObject {
    /// This method is to fetch all user types from the api store them in user tpe array and pass them to UI
    /// - Parameter completionHandler: If success, it will return the user tpes. Else Error will be returned.
    func fetchUserTypes(_ completionHandler: (([UserTypeElement]?, Error?) -> Void)? = nil) {
        let api = APIRequest(api: .userTypes, params: nil)
        api.invoke { result, error, _ in

            if error == nil {
                var userTypes = [UserTypeElement]()
                do {
                    let jsonDecoder = JSONDecoder()
                    userTypes = try jsonDecoder.decode([UserTypeElement].self, from: result as? Data ?? Data())
                    completionHandler!(userTypes, nil)
                } catch {
                    var parseError: NSError?
                    var message: String?
                    var errorCode: Int?

                    message = "Unable to parse user types from response"

                    #if DEBUG
                        print(message!)
                    #endif

                    errorCode = 5005
                    parseError = NSError(domain: message ?? "",
                                         code: errorCode!,
                                         userInfo: nil)

                    completionHandler!(nil, parseError)
                }

            } else {
                completionHandler!(nil, error)
            }
        }
    }

    /// This method is to fetch  the  set of high schools from the api as per the query, store them in school array and pass them to UI
    /// - Parameter query: query string with which the search should be done.
    /// - Parameter completionHandler: If success, it will return the set of schools. Else Error will be returned.
    func fetchHighSchools(query: String? = nil, _ completionHandler: (([School]?, Error?, String?) -> Void)? = nil) {
        let api = APIRequest(api: .schools, params: (query != nil) ? ["query": query ?? ""] : nil)
        api.invoke { result, error, _ in

            if error == nil {
                var schools = [School]()

                do {
                    let jsonDecoder = JSONDecoder()
                    schools = try jsonDecoder.decode([School].self, from: result as? Data ?? Data())
                    completionHandler!(schools, nil, query)
                } catch {
                    var parseError: NSError?
                    var message: String?
                    var errorCode: Int?

                    message = "Unable to parse Schools from response"

                    #if DEBUG
                        print(message!)
                    #endif

                    errorCode = 5005
                    parseError = NSError(domain: message ?? "",
                                         code: errorCode!,
                                         userInfo: nil)

                    completionHandler!(nil, parseError, query)
                }

            } else {
                completionHandler!(nil, error, query)
            }
        }
    }

    /// This method is to submit the analytics data obtained from the user, to the server
    /// - Parameter deviceId: Unique device Id of the current iOS device (iOS Device Vendor Id)
    /// - Parameter userType: user type option selected by the user
    /// - Parameter school: School selected by the user
    /// - Parameter customSchool: the school name which is given by the user in the search field (Takes only if no pre defined school is selected from the list,by the user)
    /// - Parameter completionHandler: If success, it will return true. Else false & Error will be returned.
    func submitUserAnalytics(deviceId: String,
                             userType: UserTypeElement,
                             school: School? = nil,
                             customSchool: String? = nil,
                             completionHandler: ((Bool, Error?) -> Void)? = nil) {
        if school == nil, customSchool == nil {
            if completionHandler != nil {
                var error: NSError?
                var message: String?
                var errorCode: Int?

                if school == nil, customSchool == nil {
                    message = "Invalid school section"
                    errorCode = 5001
                }

                error = NSError(domain: message ?? "",
                                code: errorCode ?? 0,
                                userInfo: nil)
                completionHandler!(false, error)
            }

        } else {
            var params: [String: String]?

            params = ["device_id": deviceId,
                      "user_type": userType.uid,
                      "school": school?.uid ?? "",
                      "custom_school": customSchool ?? ""]

            let api = APIRequest(api: .submitAnalytics, params: params)
            api.invoke { _, error, _ in

                if error == nil {
                    KeychainSwift().set(true, forKey: Key.isAnalyticsSubmited.rawValue)
                    completionHandler!(true, error)
                } else {
                    completionHandler!(false, error)
                }
            }
        }
    }
}
