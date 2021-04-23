//
//  College.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 07/12/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation

class CollegeReponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let pageNumber, perPage, total: Int?
    let results: Colleges?

    enum CodingKeys: String, CodingKey {
        case count, next, previous
        case pageNumber = "page_number"
        case perPage = "per_page"
        case total, results
    }
}

// MARK: - College

class College: Codable {
    let name, uid: String
    let location: Location
    let logo, tags, disabilityAccessURL: String?
    var imageLocalFilePath: String?

    enum CodingKeys: String, CodingKey {
        case name, uid, location, logo, tags, imageLocalFilePath
        case disabilityAccessURL = "disability_access_url"
    }
}

// MARK: - Location

struct Location: Codable {
    let longitude, latitude: Double
}

typealias Colleges = [College]
