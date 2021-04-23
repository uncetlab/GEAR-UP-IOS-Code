//
//  MenuElement_Extension.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 25/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation

extension MenuElement {
    /// This method is to check the icon file path exists or not
    func iconLocalFilePathExists() -> Bool {
        return ((iconLocalFilePath != nil) && (iconLocalFilePath!.count > 0)) ? true : false
    }
}
