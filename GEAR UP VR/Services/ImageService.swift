//
//  ImageService.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 12/11/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation

class ImageService: NSObject {
    /// This method is to fetch menu icon image from the location obtained
    /// - Parameter path: source file path
    /// - Parameter completionHandler: If success returns image data, else returns error
    func fetchImage(path: String, completionHandler: ((Any?, Error?) -> Void)? = nil) {
        let api = APIRequest(api: .image, params: nil, pathComp: path)
        api.invoke { result, error, _ in

            if completionHandler != nil {
                completionHandler!(result, error)
            }
        }
    }

    /// This method is to fetch video thumbnail image  from the server
    /// - Parameter video:thumbnail object
    /// - Parameter completionHandler: If success, returns thumbnail image, else error
    func fetchVideoThumbnailImage(video: Video, completionHandler: ((Video, Error?) -> Void)? = nil) {
        if let imagePath = video.thumbnail {
            fetchImage(path: String(imagePath)) { imageResponse, error in
                var parseError: Error?
                if error == nil, let imageData: Data = imageResponse as? Data {
                    let mySubstring = imagePath.suffix(imagePath.count - 7)
                    video.imageLocalFilePath = imageData.saveAsImageInDocumentDirectory(path: String(mySubstring))
                } else {
                    let message = "Unable to download thumbnail image from the location"
                    let errorCode = 5012
                    parseError = NSError(domain: message,
                                         code: errorCode,
                                         userInfo: nil)
                }
                if completionHandler != nil {
                    completionHandler!(video, parseError)
                }
            }
        }
    }
}
