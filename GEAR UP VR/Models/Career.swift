//
//  Career.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 28/04/2020.
//  Copyright © 2020 Marlabs Inc. All rights reserved.
//

import Foundation

// MARK: - Career
class CareerResponse: Codable {
    let count: Int?
    let next, previous: Int?
    let offset: Int?
    let results: [Career]

    enum CodingKeys: String, CodingKey {
           case count, next, previous, offset
           case results = "results"
       }
}

// MARK: - Result
class Career: Codable {
    let career, uid: String
    let logo: String?
    var imageLocalFilePath: String?
}
