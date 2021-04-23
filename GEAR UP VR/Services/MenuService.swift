//
/////  MenuService.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 22/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation

class MenuService: NSObject {
    /// This method is to fetch all menu items from the server
    /// - Parameter completionHandler: If success, returns array of menu elements else returns error
    func fetchMenuItems(completionHandler: (([MenuElement]?, Error?) -> Void)? = nil) {
        let api = APIRequest(api: .menu, params: nil)
        api.invoke { result, error, _ in

            if error == nil {
                var menu = [MenuElement]()
                do {
                    let jsonDecoder = JSONDecoder()
                    menu = try jsonDecoder.decode([MenuElement].self, from: result as? Data ?? Data())

                    var downloadCount = 0
                    var parseError: Error?

                    let imageService = ImageService()

                    for menuElement in menu {
                        imageService.fetchImage(path: menuElement.icon ?? "") { imageResponse, error in

                            downloadCount += 1

                            if error == nil, let imageData: Data = imageResponse as? Data {
                                menuElement.iconLocalFilePath = imageData.saveAsImageInDocumentDirectory(path: menuElement.title + ".png")

                            } else {
                                let message = "Unable to download menu images from location"
                                let errorCode = 5007
                                parseError = NSError(domain: message,
                                                     code: errorCode,
                                                     userInfo: nil)
                            }

                            if downloadCount >= menu.count,
                                completionHandler != nil {
                                completionHandler!(menu, parseError)
                            }
                        }
                    }

                } catch {
                    var parseError: NSError?
                    var message: String?
                    var errorCode: Int?

                    message = "Unable to parse menu elements from response"

                    #if DEBUG
                        print(message!)
                    #endif

                    errorCode = 5006
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
}
