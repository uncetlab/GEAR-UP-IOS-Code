//
//  ContentPageService.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 06/11/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation
class ContentPageService: NSObject {
    /// This method is to fetch page content source
    /// - Parameter pageId: Page Identifier
    /// - Parameter completionHandler: If success, returns html source, else error
    func fetchPage(pageId: String, completionHandler: ((Page?, Error?) -> Void)? = nil) {
        let api = APIRequest(api: .page, params: nil, pathComp: pageId)
        api.invoke { result, error, _ in

            var page: Page?
            var errorReturns: Error?
            var errorCode: Int?

            if result != nil {
                do {
                    let jsonDecoder = JSONDecoder()
                    page = try jsonDecoder.decode(Page.self, from: result as? Data ?? Data())
                } catch {
                    errorCode = 5008
                    errorReturns = NSError(domain: "Unable to parse page data from response",
                                           code: errorCode!,
                                           userInfo: nil)
                }
            } else if error != nil {
                errorReturns = error
            } else {
                errorCode = 5008
                errorReturns = NSError(domain: "Unable to load data. Please try after some time.",
                                       code: errorCode!,
                                       userInfo: nil)
            }

            if completionHandler != nil {
                completionHandler!(page, errorReturns)
            }
        }
    }
}
