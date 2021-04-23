//
//  Home.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 01/11/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation

// MARK: - Home

class Home: Codable {
    let uid, title: String
    let video: Video?
    let activeTiles: [DashboardTile]

    enum CodingKeys: String, CodingKey {
        case uid, title, video
        case activeTiles = "active_tiles"
    }
}

// MARK: - ActiveTile

class DashboardTile: Codable {
    init(with menuItem: MenuElement) {
        page = menuItem.page
        url = menuItem.url
        title = menuItem.title
        urlType = menuItem.urlType
        image = menuItem.icon
        imageLocalFilePath = menuItem.iconLocalFilePath
        tileDescription = ""
        order = menuItem.order
    }

    let title, image: String?
    let url: String?
    let urlType: String?
    let tileDescription: String?
    let order: Int
    let page: String?
    var imageLocalFilePath: String?

    enum CodingKeys: String, CodingKey {
        case title, image, url
        case urlType = "url_type"
        case tileDescription = "description"
        case order, page
    }
}
