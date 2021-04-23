//
//  UIFont_Extension.swift
//  GEAR UP VR
//
//  Created by Ansarsha on 28/02/20.
//  Copyright © 2020 Marlabs Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    /// User_type_selection
    open class var userTypeTitleFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 14)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 14)
        }
    }

    open class var userSelectionTitleFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 18)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 18)
        }
    }

    /// HighSchool_selection
    open class var highSchoolSelectionTitleFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 18)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 18)
        }
    }

    open class var highSchoolListTitleFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 15)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 15)
        }
    }

    /// ApplicationErrorViewController
    open class var applicationErrorViewControllerMainTitleFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Bold", size: 22)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Bold", size: 22)
        }
    }

    open class var applicationErrorViewControllerUserInfoFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 13)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 13)
        }
    }

    open class var applicationErrorViewControllerTryButtonFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 17)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 17)
        }
    }

    open class var menuMoreItemFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Bold", size: 17)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Bold", size: 17)
        }
    }

    open class var menuTabbarItemFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Bold", size: 17)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Bold", size: 17)
        }
    }

    open class var stateSelectionFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 13)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 13)
        }
    }

    open class var rangeSliderTitleFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 14)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 14)
        }
    }

    open class var rangeMinMaxLabelFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 14)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 14)
        }
    }

    open class var majorsTitleFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 14)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 14)
        }
    }

    open class var majorsCountFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 14)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 14)
        }
    }

    open class var bodySizeTitleFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 14)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 14)
        }
    }

    open class var bodySizeOptionFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 14)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 14)
        }
    }

    open class var majorSelectionApplyButtonFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 14)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 14)
        }
    }

    open class var majorSearchFieldFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 15)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 15)
        }
    }

    open class var majorSelectionResetButtonFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 14)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 14)
        }
    }

    /// Home_page
    open class var homeTableViewCellTitleFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 16)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 16)
        }
    }

    open class var homeTableViewCellDetailsFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 12)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 12)
        }
    }

    /// Visit_NC_College
    open class var visitNCListTitleFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 15)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 15)
        }
    }

    open class var visitNCListTagFont: UIFont? {
        switch config.theme {
        case .mississippiDark, .mississippiLight: return UIFont(name: "Roboto-Regular", size: 12)
        case .uncDark, .uncLight: return UIFont(name: "Roboto-Regular", size: 12)
        }
    }
}
