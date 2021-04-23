//
//  BundleExtension.swift
//  GEAR UP VR
//
//  Created by Ansarsha on 04/02/20.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import Foundation

extension Bundle {
    var displayName: String {
        if let name = object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return name
        } else if let name = object(forInfoDictionaryKey: "CFBundleName") as? String {
            return name
        } else {
            return ""
        }
    }
}
