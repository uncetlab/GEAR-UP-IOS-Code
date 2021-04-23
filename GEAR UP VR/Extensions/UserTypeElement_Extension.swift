//
//  UserTypeElement_Extension.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 15/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation
import UIKit

extension UserTypeElement {
    /// This method returns the corressponding image name based on the user type name
    func getImage() -> UIImage? {
        switch config.theme {
        case .mississippiDark, .mississippiLight:
            switch title {
            case "Student": return UIImage.studentIcon
            case "Teacher": return UIImage.teacherIcon
            case "Parent": return UIImage.parentIcon
            case "Non Traditional": return UIImage.nonTraditionalIcon
            case "Other": return UIImage.othersIcon
            default: return UIImage.othersIcon
            }
        case .uncDark, .uncLight:
            switch title {
            case "Student": return UIImage.studentIcon
            case "Teacher": return UIImage.teacherIcon
            case "Parent": return UIImage.parentIcon
            case "Non Traditional": return UIImage.nonTraditionalIcon
            case "Other": return UIImage.othersIcon
            default: return UIImage.othersIcon
            }
        }
    }
}
