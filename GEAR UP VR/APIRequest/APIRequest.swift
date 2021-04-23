//
//  APIRequest.swift
//  NextConnect
//
//  Created by Harikrishnan on 30/09/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation
import KeychainSwift

enum API: String {
    case token
    case userTypes
    case schools
    case submitAnalytics
    case menu
    case home
    case collegesList
    case collegesDetails
    case image = ""
    case page
    case majors
    case careers

    var path: String {
        switch self {
        case .token: return "api/token/"
        case .userTypes: return "api/user_types/"
        case .schools: return "api/schools/"
        case .submitAnalytics: return "api/schools/"
        case .menu: return "api/menus/"
        case .page: return "api/pages"
        case .home: return "api/home_page/"
        case .collegesList: return "api/colleges/"
        case .collegesDetails: return "api/colleges/"
        case .image: return ""
        case .majors: return "api/majors/"
        case .careers: return "api/careers/"

        }
    }

    var HTTPMethod: HTTPMethod {
        switch self {
        case .token: return .POST
        case .userTypes: return .GET
        case .schools: return .GET
        case .submitAnalytics: return .POST
        case .menu: return .GET
        case .page: return .GET
        case .image: return .GET
        case .home: return .GET
        case .collegesList: return .POST
        case .collegesDetails: return .GET
        case .majors: return .GET
        case .careers: return .GET
        }
    }

    var isSecured: Bool {
        switch self {
        case .token:
            return false
        default:
            return true
        }
    }
}

class APIRequest: NSObject {
    var request: URLRequest?

    private var api: API?

    private let config = Configuration()

    override init() {}

    /// This method is to initialize an API request object.
    /// - Parameter api: enum that contains API  characteristics
    /// - Parameter params: parameters that are required to be passed along with the api
    /// - Parameter pathComp: API path component
    /// - Parameter additionalHeaders: additional headers that are required to be passed along with the api
    init(api: API, params: Any? = nil, pathComp: String? = nil, additionalHeaders: [String: String]? = nil) {
        self.api = api

        var urlComp = URLComponents(string: config.baseURL + api.path)

        if pathComp != nil {
            let path = (urlComp?.path.appending("/" + pathComp!))!
            urlComp?.path = path
        }

        if params != nil {
            switch api.HTTPMethod {
            case .GET, .DELETE:
                if let dict = params as? [String: Any] {
                    var queries = [URLQueryItem]()
                    for (key, value) in dict {
                        if let strValue = value as? String {
                            let query = URLQueryItem(name: key, value: strValue)
                            queries.append(query)
                        } else if let values = value as? [String] {
                            values.forEach { val in
                                let query = URLQueryItem(name: key, value: val)
                                queries.append(query)
                            }
                        }
                    }
                    urlComp?.queryItems = queries
                }

            case .POST, .PUT:
                do {
                    let json = try JSONSerialization.data(withJSONObject: params as Any,
                                                          options: .prettyPrinted)
                    request = URLRequest(url: (urlComp?.url)!)
                    request?.setValue("application/json", forHTTPHeaderField: "Content-Type")

                    request?.httpBody = json
                } catch {
                    #if DEBUG
                        print(error.localizedDescription)
                    #endif
                }
            }
        }

        if request == nil {
            if var query = urlComp?.percentEncodedQuery {
                query = query.replacingOccurrences(of: "+", with: "%2B")
                urlComp?.percentEncodedQuery = query.replacingOccurrences(of: ":", with: "%3A")
            }

            request = URLRequest(url: (urlComp?.url)!)
        }

        request?.setValue("application/json", forHTTPHeaderField: "Accept")
        if additionalHeaders != nil {
            for (key, value) in additionalHeaders! where !key.isEmpty && !value.isEmpty {
                request?.setValue(value, forHTTPHeaderField: key)
            }
        }
        request?.httpMethod = api.HTTPMethod.rawValue
    }

    /// This method is to invoke a new api request
    /// - Parameter completionHandler: If success, it will return the response. Else Error will be returned.
    func invoke(_ completionHandler: ((Any?, Error?, HTTPURLResponse?) -> Void)? = nil) {
        if #available(iOS 13.0, *) {} else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        #if DEBUG
            print("request: " + (request?.description)!)
        #endif

        if api!.isSecured {
            if let accessToken = KeychainSwift().get(Key.accessToken.rawValue) {
                request?.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
                createConection(completionHandler)
            } else {
                authenticateUser { token, _ in
                    if token != nil {
                        KeychainSwift().set(token!, forKey: Key.accessToken.rawValue)
                        self.request?.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
                        self.createConection(completionHandler)
                    } else {
                        #if DEBUG
                            print("Unable to obtain token from the server")
                        #endif

                        let err = NSError(domain: "Unable to obtain token from the server",
                                          code: 403,
                                          userInfo: nil)

                        if completionHandler != nil {
                            completionHandler!(nil, err, nil)
                        }
                    }
                }
            }
        } else {
            createConection(completionHandler)
        }
    }

    func createConection(_ completionHandler: ((Any?, Error?, HTTPURLResponse?) -> Void)? = nil) {
        #if DEBUG
            do {
                if request?.httpBody != nil {
                    let headers = request?.allHTTPHeaderFields
                    if let contentType = headers?["Content-Type"] {
                        if contentType.contains("application/json") {
                            let obj = try JSONSerialization.jsonObject(with: (request?.httpBody)!,
                                                                       options: .allowFragments)
                            print("")
                            print("*********************")
                            print("\tAPI Request Body:")
                            print("*********************")
                            print(obj)
                            print("*********************")
                            print(" ")
                            print(" ")
                        }
                    }
                }
            } catch {
                print(error)
            }
        #endif

        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: self,
                                 delegateQueue: OperationQueue.main)

        session.dataTask(with: request!) { data, response, error in

            if #available(iOS 13, *) {} else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            if error != nil {

                // If error returns while executing any API calls other than / before authenticate user
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.prepareRootViewController(errorStatusCode: .genericError, animated: true)
                }

            } else {
                do {
                    if data != nil, (data?.count)! <= 0 {
                        if completionHandler != nil {
                            completionHandler!(nil, error, response as? HTTPURLResponse)
                        }
                        return
                    }

                    if let res = response as? HTTPURLResponse {
                        #if DEBUG
                            var obj = data as Any
                            if let contentType = res.allHeaderFields["Content-Type"] {
                                if let contentTypeStr = contentType as? String,
                                    contentTypeStr.contains("application/json") {
                                    obj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                                }
                            }

                            print(" ")
                            print("URL: \(String(describing: res.url))")
                            print("*********************")
                            print("\tAPI Response:")
                            print("*********************")
                            print(obj)
                            print("*********************")
                            print(" ")
                            print(" ")
                        #endif

                        if (res.statusCode == 401 || res.statusCode == 403) && (self.api?.isSecured)! {
                            KeychainSwift().delete(Key.accessToken.rawValue)

                            self.authenticateUser { token, error in
                                if token != nil {
                                    self.request?.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
                                    self.invoke { result, error, _ in
                                        if error == nil {
                                            completionHandler!(result, error, res)
                                        } else {
                                            completionHandler!(nil, error, res)
                                        }
                                    }
                                } else {
                                    completionHandler!(nil, error, res)
                                }
                            }
                        } else if res.statusCode == 200 || res.statusCode == 201 {
                            if completionHandler != nil {
                                completionHandler!(data, nil, res)
                            }
                        } else {
                            if completionHandler != nil {
                                completionHandler!(nil,
                                                   NSError(domain: "domain Message",
                                                           code: res.statusCode,
                                                           userInfo: [NSLocalizedDescriptionKey: "Unhandled error"]),
                                                   res)
                            }
                        }
                    }

                } catch {
                    if completionHandler != nil {
                        completionHandler!(nil, error, response as? HTTPURLResponse)
                    }
                }
            }

        }.resume()
    }
}

extension APIRequest: URLSessionDelegate {

}

extension APIRequest {
    /// This method is to authenticate user with default username & password and obtain access token from the API.
    /// Once the access token is obtained, the same will be stored in the keychain in order to use it for future API calls.
    /// - Parameter completionHandler: If passed,access token will be obtained. Else error will be thrown.

    func authenticateUser(_ completionHandler: ((String?, Error?) -> Void)? = nil) {
        let parameters = ["username": config.username,
                          "password": config.password]

        let api = APIRequest(api: .token, params: parameters)

        api.invoke { result, _, res in

            if result != nil {
                var accessToken: String?
                var err: NSError?

                do {
                    if let data = result as? Data {
                        if let dict = try JSONSerialization.jsonObject(with: data,
                                                                       options: .allowFragments) as? [String: Any] {
                            accessToken = dict["access"] as? String
                            if accessToken != nil && !accessToken!.isEmpty {
                                KeychainSwift().set(accessToken!, forKey: Key.accessToken.rawValue)
                            }
                        }
                    }
                } catch let exception {
                    err = NSError(domain: "Catch Error",
                                  code: 4010,
                                  userInfo: [NSLocalizedDescriptionKey: exception.localizedDescription])
                }

                if accessToken == nil, err == nil {
                    err = NSError(domain: "Unable to obtain AccessToken",
                                  code: 4000,
                                  userInfo: nil)
                }

                if completionHandler != nil {
                    completionHandler!(accessToken, err)
                }
            } else if (res?.statusCode) != nil {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    switch res?.statusCode {
                    case 404:
                        appDelegate.prepareRootViewController(errorStatusCode: .invalidUniversity, animated: true)

                    case 403, 401:
                        appDelegate.prepareRootViewController(errorStatusCode: .invalidUser, animated: true)

                    default:
                         appDelegate.prepareRootViewController(errorStatusCode: .genericError, animated: true)
                    }

                    completionHandler!(nil, NSError(domain: ErrorMessages.genericErrorInfo + self.config.contactEmail ,
                    code: 4007,
                    userInfo: nil))
                }

            } else if completionHandler != nil {
                 if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.prepareRootViewController(errorStatusCode: .genericError, animated: true)
                }
            }
        }
    }
}
