//
//  Major.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 09/01/2020.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import Foundation

// MARK: - Major

class Major: Codable {
    let uid, title, majorDescription: String?

    enum CodingKeys: String, CodingKey {
        case uid, title
        case majorDescription = "description"
    }
}

typealias Majors = [Major]
