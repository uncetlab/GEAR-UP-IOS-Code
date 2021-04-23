//
//  CollegeFilter.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 10/01/2020.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import Foundation
struct CollegeFilter {
    var inState: Bool?
    var satScore: Scale?
    var actScore: Scale?
    var majors: [Major]
    var studentSize: Size?
    var costPerYear: Scale?
}

struct Scale {
    var minimum: Int
    var maxiumum: Int
}

enum Size: Int {
    case lowest = 0
    case lowIntermediate = 1
    case highIntermediate = 2
    case highest = 3
}
