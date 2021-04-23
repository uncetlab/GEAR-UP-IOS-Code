//
//  MenuElement.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 22/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//
import Foundation

// MARK: - MenuElement

class MenuElement: Codable {
    let uid, title: String
    let icon: String?
    let urlType: String
    let url: String?
    let active: Bool
    let order: Int
    let page: String?
    let keyName: String?
    var iconLocalFilePath: String?

    enum CodingKeys: String, CodingKey {
        case uid, title, icon, iconLocalFilePath
        case urlType = "url_type"
        case url, active, order, page
        case keyName = "key_name"
    }
}

typealias Menu = [MenuElement]
