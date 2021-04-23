//
//  UserType.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 03/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation

// MARK: - UserTypeElement

struct UserTypeElement: Codable {
    let uid, title: String
}

typealias UserType = [UserTypeElement]
