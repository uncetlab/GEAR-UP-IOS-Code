//
//  HomeService.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 31/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation

class HomeService: NSObject {
    /// This method is to fetch all menu items from the server
    /// - Parameter completionHandler: If success, returns array of menu elements else returns error
    func fetchHomeScreenItems(completionHandler: ((Home?, Error?) -> Void)? = nil) {
        let api = APIRequest(api: .home, params: nil)
        api.invoke { result, error, _ in
            var home: Home?
            var parseError: Error?
            if error == nil {
                do {
                    let jsonDecoder = JSONDecoder()
                    home = try jsonDecoder.decode(Home.self, from: result as? Data ?? Data())
                } catch {
                    let message = "Unable to parse the response obtained from the Home page API"
                    let errorCode = 5008
                    parseError = NSError(domain: message,
                                         code: errorCode,
                                         userInfo: nil)
                }
            } else {
                parseError = error
            }
            if completionHandler != nil {
                completionHandler!(home, parseError)
            }

            if completionHandler != nil {
                completionHandler!(home, parseError)
            }
        }
    }

    /// This method is to fetch item image  from the server
    /// - Parameter tile:item object
    /// - Parameter completionHandler: If success, returns tile, else error
    func fetchActiveTileImage(tile: DashboardTile, completionHandler: ((DashboardTile?, Error?) -> Void)? = nil) {
        if let imagePath = tile.image {
            let imageService = ImageService()
            imageService.fetchImage(path: String(imagePath)) { imageResponse, error in
                var parseError: Error?
                if error == nil, let imageData: Data = imageResponse as? Data {
                    let mySubstring = imagePath.suffix(imagePath.count - 7)
                    tile.imageLocalFilePath = imageData.saveAsImageInDocumentDirectory(path: String(mySubstring))
                } else {
                    let message = "Unable to download tile image from the location"
                    let errorCode = 5007
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
