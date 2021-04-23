//
//  MinMax.swift
//  GEAR UP VR
//
//  Created by Shineeth Hamza on 11/02/20.
//  Copyright © 2020 Marlabs Inc. All rights reserved.
//

import Foundation

enum Operation: String {
    case bt, gt, lt, eq, none
}

struct MinMax: Equatable {
    var min: Float
    var max: Float
    var operation: Operation = Operation.none

    func toDictionary(numberFormatter: NumberFormatter? = nil) -> [String: String] {
        if let formatter = numberFormatter {
            return ["min": formatter.string(for: min) ?? "",
                    "max": formatter.string(for: max) ?? ""]
        }
        return ["min": String(min),
                "max": String(max)]
    }

    static func == (lhs: MinMax, rhs: MinMax) -> Bool {
        return lhs.min == rhs.min && lhs.max == rhs.max && lhs.operation == rhs.operation
    }
}
