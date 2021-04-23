//
//  Video.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 15/11/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import UIKit

// MARK: - Video

class Video: Codable {
    let thumbnail: String?
    let uid, name: String
    var url: String
    var imageLocalFilePath: String?
}

extension Video {
    enum CodingKeys: CodingKey {
        case thumbnail, uid, name, url
    }
}
