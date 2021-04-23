//
//  UIColor_Extension.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 28/10/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation
import UIKit

let config = Configuration()
// swiftlint:disable file_length
extension UIColor {
	/// User_type_selection
	open class var userSelectionTitleColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.white
				case .mississippiLight: return UIColor.white
				case .uncDark: return UIColor.white
				case .uncLight: return UIColor.white
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.white
			case .unc: return UIColor.white
			}
		}
	}

	open class var userTypeTitleColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.white
				case .uncDark: return UIColor.white
				case .mississippiLight: return UIColor.black
				case .uncLight: return UIColor.black
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.black
			case .unc: return UIColor.black
			}
		}
	}

	open class var userTypeCellBGColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.80)
				case .uncDark: return UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.80)
				case .mississippiLight: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.80)
				case .uncLight: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.80)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.80)
			case .unc: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.80)
			}
		}
	}

	/// HighSchool_selection
	open class var highSchoolSelectionCellBGColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.black
				case .uncDark: return UIColor.black
				case .mississippiLight: return UIColor.white
				case .uncLight: return UIColor.white
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.white
			case .unc: return UIColor.white
			}
		}
	}

	open class var highSchoolListTitleColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 203 / 255.0, green: 203 / 255.0, blue: 203 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 203 / 255.0, green: 203 / 255.0, blue: 203 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 103 / 255.0, green: 103 / 255.0, blue: 103 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 103 / 255.0, green: 103 / 255.0, blue: 103 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 103 / 255.0, green: 103 / 255.0, blue: 103 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 103 / 255.0, green: 103 / 255.0, blue: 103 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var highSchoolSelectionTitleColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.white
				case .uncDark: return UIColor.white
				case .mississippiLight: return UIColor.white
				case .uncLight: return UIColor.white
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.white
			case .unc: return UIColor.white
			}
		}
	}

	open class var searchBarSeperatorLine: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 172 / 255.0, green: 172 / 255.0, blue: 172 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 172 / 255.0, green: 172 / 255.0, blue: 172 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 172 / 255.0, green: 172 / 255.0, blue: 172 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 172 / 255.0, green: 172 / 255.0, blue: 172 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var highSchoolSearchFieldTextColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 203 / 255.0, green: 203 / 255.0, blue: 203 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 203 / 255.0, green: 203 / 255.0, blue: 203 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 117 / 255.0, green: 117 / 255.0, blue: 117 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 117 / 255.0, green: 117 / 255.0, blue: 117 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 117 / 255.0, green: 117 / 255.0, blue: 117 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 117 / 255.0, green: 117 / 255.0, blue: 117 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var tableViewLineSeperatorColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.82)
				case .uncDark: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.82)
				case .mississippiLight: return UIColor(red: 126 / 255.0, green: 126 / 255.0, blue: 126 / 255.0, alpha: 0.5)
				case .uncLight: return UIColor(red: 126 / 255.0, green: 126 / 255.0, blue: 126 / 255.0, alpha: 0.5)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 126 / 255.0, green: 126 / 255.0, blue: 126 / 255.0, alpha: 0.5)
			case .unc: return UIColor(red: 126 / 255.0, green: 126 / 255.0, blue: 126 / 255.0, alpha: 0.5)
			}
		}
	}

	/// ApplicationErrorViewController
	open class var applicationErrorViewControllerBGColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.black
				case .uncDark: return UIColor.black
				case .mississippiLight: return UIColor.white
				case .uncLight: return UIColor.white
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.white
			case .unc: return UIColor.white
			}
		}
	}

	open class var applicationErrorViewControllerMainTitleColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 99 / 255.0, green: 198 / 255.0, blue: 239 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 99 / 255.0, green: 198 / 255.0, blue: 239 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 99 / 255.0, green: 198 / 255.0, blue: 239 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 99 / 255.0, green: 198 / 255.0, blue: 239 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 99 / 255.0, green: 198 / 255.0, blue: 239 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 99 / 255.0, green: 198 / 255.0, blue: 239 / 255.0, alpha: 1)
			}
		}
	}

	open class var applicationErrorViewControllerUserInfoColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiLight: return UIColor.black
				case .mississippiDark: return UIColor.white
				case .uncDark: return UIColor.white
				case .uncLight: return UIColor.black
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.black
			case .unc: return UIColor.black
			}
		}
	}

	open class var applicationErrorViewControllerTryButtonBgColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiLight: return UIColor(red: 99 / 255.0, green: 198 / 255.0, blue: 239 / 255.0, alpha: 1)
				case .mississippiDark: return UIColor(red: 99 / 255.0, green: 198 / 255.0, blue: 239 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 99 / 255.0, green: 198 / 255.0, blue: 239 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 99 / 255.0, green: 198 / 255.0, blue: 239 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 99 / 255.0, green: 198 / 255.0, blue: 239 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 99 / 255.0, green: 198 / 255.0, blue: 239 / 255.0, alpha: 1)
			}
		}
	}

	open class var applicationErrorViewControllerTryButtonTextColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiLight: return UIColor.white
				case .mississippiDark: return UIColor.white
				case .uncLight: return UIColor.white
				case .uncDark: return UIColor.white
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.white
			case .unc: return UIColor.white
			}
		}
	}

	/// color of navigation bar buttons and title
	open class var navigationBarTintColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.white
				case .mississippiLight: return UIColor.white
				case .uncDark: return UIColor.white
				case .uncLight: return UIColor(red: 45.0 / 255.0, green: 50.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0) // rgba(45, 50, 86, 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.white
			case .unc: return UIColor(red: 45.0 / 255.0, green: 50.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0) // rgba(45, 50, 86, 1)
			}
		}
	}

	open class var navigationBarBackgroundColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiLight: return UIColor(red: 0.0 / 255.0, green: 39.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
				case .mississippiDark: return UIColor(red: 0.0 / 255.0, green: 13.0 / 255.0, blue: 28.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor.white
				case .uncDark: return UIColor.black
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 0.0 / 255.0, green: 39.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor.white
			}
		}
	}

	open class var tabBarBgColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.black
				case .uncDark: return UIColor.black
				case .mississippiLight: return UIColor.white
				case .uncLight: return UIColor.white
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.white
			case .unc: return UIColor.white
			}
		}
	}

	open class var tabBarTintColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 172.0 / 255.0, green: 173.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 172.0 / 255.0, green: 173.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 172.0 / 255.0, green: 173.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 172.0 / 255.0, green: 173.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 172.0 / 255.0, green: 173.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 172.0 / 255.0, green: 173.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var tabBarTintSelectedColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 54.0 / 255.0, green: 147.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 54.0 / 255.0, green: 147.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 45.0 / 255.0, green: 50.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 45.0 / 255.0, green: 50.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 45.0 / 255.0, green: 50.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 45.0 / 255.0, green: 50.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
			}
		}
	}

	/// MenuViewController
	open class var menuViewControllerBgColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var menuViewControllerCellBgColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var menuViewControllerCellImageTintColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 230.0 / 255.0, green: 230.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 230.0 / 255.0, green: 230.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 81.0 / 255.0, green: 83.0 / 255.0, blue: 91.0 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 81.0 / 255.0, green: 83.0 / 255.0, blue: 91.0 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 81.0 / 255.0, green: 83.0 / 255.0, blue: 91.0 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 81.0 / 255.0, green: 83.0 / 255.0, blue: 91.0 / 255.0, alpha: 1)
			}
		}
	}

	open class var menuViewControllerCellArrowTintColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.white
				case .uncDark: return UIColor.white
				case .mississippiLight: return UIColor(red: 134.0 / 255.0, green: 136.0 / 255.0, blue: 151.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 134.0 / 255.0, green: 136.0 / 255.0, blue: 151.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 134.0 / 255.0, green: 136.0 / 255.0, blue: 151.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 134.0 / 255.0, green: 136.0 / 255.0, blue: 151.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var menuViewControllerCellTextTintColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.white
				case .uncDark: return UIColor.white
				case .mississippiLight: return UIColor.darkGray
				case .uncLight: return UIColor.darkGray
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.black
			case .unc: return UIColor.black
			}
		}
	}

	/// NC College Filter Cells :- StateSelectionTableViewCell
	open class var stateSelectionRadioButtonTintColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 25 / 255.0, green: 134 / 255.0, blue: 189 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 54.0 / 255.0, green: 147.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 0 / 255.0, green: 39 / 255.0, blue: 80 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor.darkGray
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 0 / 255.0, green: 39 / 255.0, blue: 80 / 255.0, alpha: 1.0)
			case .unc: return UIColor.darkGray
			}
		}
	}

	open class var stateSelectionRadioButtonTextTintColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var rangeSliderTitleColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.white
				case .uncDark: return UIColor(red: 162.0 / 255.0, green: 242.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 9 / 255.0, green: 59 / 255.0, blue: 49 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 9 / 255.0, green: 39 / 255.0, blue: 139 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 9 / 255.0, green: 59 / 255.0, blue: 49 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 9 / 255.0, green: 39 / 255.0, blue: 139 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var rangeSliderMinMaxColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 145.0 / 255.0, green: 145.0 / 255.0, blue: 145.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 145.0 / 255.0, green: 145.0 / 255.0, blue: 145.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 145.0 / 255.0, green: 145.0 / 255.0, blue: 145.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 145.0 / 255.0, green: 145.0 / 255.0, blue: 145.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var rangeSliderTintColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 25 / 255.0, green: 134 / 255.0, blue: 189 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 54.0 / 255.0, green: 147.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 0 / 255.0, green: 39 / 255.0, blue: 80 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 0 / 255.0, green: 39 / 255.0, blue: 80 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var majorCellTitleColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.white
				case .uncDark: return UIColor(red: 162.0 / 255.0, green: 242.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 0 / 255.0, green: 59 / 255.0, blue: 49 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 43.0 / 255.0, green: 68.0 / 255.0, blue: 148.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 0 / 255.0, green: 59 / 255.0, blue: 49 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 43.0 / 255.0, green: 68.0 / 255.0, blue: 148.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var majorsCountColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var bodySizeTitleColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.white
				case .uncDark: return UIColor(red: 162.0 / 255.0, green: 242.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 9 / 255.0, green: 59 / 255.0, blue: 49 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 9 / 255.0, green: 39 / 255.0, blue: 139 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 9 / 255.0, green: 59 / 255.0, blue: 49 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 9 / 255.0, green: 39 / 255.0, blue: 139 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var bodySizeOptionColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var bodySizeOptionTintColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 25 / 255.0, green: 134 / 255.0, blue: 189 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 54.0 / 255.0, green: 147.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 0 / 255.0, green: 39 / 255.0, blue: 80 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor.darkGray
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 0 / 255.0, green: 39 / 255.0, blue: 80 / 255.0, alpha: 1.0)
			case .unc: return UIColor.darkGray
			}
		}
	}

	open class var separatorBackgroundColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.clear
				case .uncDark: return UIColor.clear
				case .mississippiLight: return UIColor(red: 236.0 / 255.0, green: 236.0 / 255.0, blue: 236.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 236.0 / 255.0, green: 236.0 / 255.0, blue: 236.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 236.0 / 255.0, green: 236.0 / 255.0, blue: 236.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 236.0 / 255.0, green: 236.0 / 255.0, blue: 236.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var sizeClearButtonTintColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 133.0 / 255.0, green: 133.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var filterApplyButtonBgColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 0 / 255.0, green: 70 / 255.0, blue: 143 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 54.0 / 255.0, green: 147.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 0 / 255.0, green: 39.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 0 / 255.0, green: 39.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var selectedMajorsCountColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 54.0 / 255.0, green: 147.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 54.0 / 255.0, green: 147.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var filterApplyButtonTintColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.white
				case .uncDark: return UIColor.white
				case .mississippiLight: return UIColor.white
				case .uncLight: return UIColor.white
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.white
			case .unc: return UIColor.white
			}
		}
	}

	open class var majorSelectionBgColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.black
				case .uncDark: return UIColor.black
				case .mississippiLight: return UIColor.white
				case .uncLight: return UIColor.white
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.white
			case .unc: return UIColor.white
			}
		}
	}

	open class var majorSelectionSearchTextColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.white
				case .uncDark: return UIColor.white
				case .mississippiLight: return UIColor.black
				case .uncLight: return UIColor.black
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.black
			case .unc: return UIColor.black
			}
		}
	}

	open class var majorSelectionApplyButtonBgColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 54.0 / 255.0, green: 147.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 54.0 / 255.0, green: 147.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var majorSelectionResetButtonTextColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 97.0 / 255.0, green: 104.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var majorSelectionApplyButtonTintColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.white
				case .uncDark: return UIColor.white
				case .mississippiLight: return UIColor.white
				case .uncLight: return UIColor.white
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.white
			case .unc: return UIColor.white
			}
		}
	}

	open class var majorSelectionResetButtonBgColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 25.0 / 255.0, green: 25.0 / 255.0, blue: 25.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 25.0 / 255.0, green: 25.0 / 255.0, blue: 25.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 246.0 / 255.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 246.0 / 255.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 246.0 / 255.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 246.0 / 255.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var majorSelectionCellTextColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 114.0 / 255.0, green: 114.0 / 255.0, blue: 114.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 114.0 / 255.0, green: 114.0 / 255.0, blue: 114.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 114.0 / 255.0, green: 114.0 / 255.0, blue: 114.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 114.0 / 255.0, green: 114.0 / 255.0, blue: 114.0 / 255.0, alpha: 1.0)
			}
		}
	}

	open class var disabilityAccessBgColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.black
				case .uncDark: return UIColor.black
				case .mississippiLight: return UIColor.white
				case .uncLight: return UIColor.white
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.white
			case .unc: return UIColor.white
			}
		}
	}

	open class var searchTextFieldColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.white
				case .uncDark: return UIColor.white
				case .mississippiLight: return UIColor.white
				case .uncLight: return UIColor(red: 29.0 / 255.0, green: 29 / 255.0, blue: 29 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.white
			case .unc: return UIColor(red: 29.0 / 255.0, green: 29 / 255.0, blue: 29 / 255.0, alpha: 1)
			}
		}
	}

	open class var searchfieldBorderColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 234.0 / 255.0, green: 234.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
				case .uncDark: return UIColor(red: 234.0 / 255.0, green: 234.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 234.0 / 255.0, green: 234.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
				case .uncLight: return UIColor(red: 234.0 / 255.0, green: 234.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 234.0 / 255.0, green: 234.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
			case .unc: return UIColor(red: 234.0 / 255.0, green: 234.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
			}
		}
	}

	/// Home_page
	open class var homeViewBGColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 30 / 255.0, green: 30 / 255.0, blue: 30 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 30 / 255.0, green: 30 / 255.0, blue: 30 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
			}
		}
	}

	open class var homeTableViewCellContainerBGColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return .black
				case .uncDark: return .black
				case .mississippiLight: return .white
				case .uncLight: return .white
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return .white
			case .unc: return .white
			}
		}
	}

	open class var homeTableViewCellContainerShadowColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 171 / 255.0, green: 166 / 255.0, blue: 166 / 255.0, alpha: 0.16)
				case .uncDark: return UIColor(red: 52 / 255.0, green: 52 / 255.0, blue: 52 / 255.0, alpha: 0.16)
				case .mississippiLight: return UIColor(red: 171 / 255.0, green: 166 / 255.0, blue: 166 / 255.0, alpha: 0.16)
				case .uncLight: return UIColor(red: 171 / 255.0, green: 166 / 255.0, blue: 166 / 255.0, alpha: 0.16)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 171 / 255.0, green: 166 / 255.0, blue: 166 / 255.0, alpha: 0.16)
			case .unc: return UIColor(red: 171 / 255.0, green: 166 / 255.0, blue: 166 / 255.0, alpha: 0.16)
			}
		}
	}

	open class var homeTableViewCellContainerBorderColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return .clear
				case .uncDark: return .clear
				case .mississippiLight: return .clear
				case .uncLight: return .clear
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return .clear
			case .unc: return .clear
			}
		}
	}

	open class var tileImageBorderColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return .clear
				case .uncDark: return .clear
				case .mississippiLight: return .clear
				case .uncLight: return .clear
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return .clear
			case .unc: return .clear
			}
		}
	}

	open class var homeTableViewCellTitleColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 252 / 255.0, green: 252 / 255.0, blue: 252 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 9 / 255.0, green: 59 / 255.0, blue: 49 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 45 / 255.0, green: 50 / 255.0, blue: 86 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 9 / 255.0, green: 59 / 255.0, blue: 49 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 45 / 255.0, green: 50 / 255.0, blue: 86 / 255.0, alpha: 1)
			}
		}
	}

	open class var homeTableViewCellDetailsColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 161 / 255.0, green: 161 / 255.0, blue: 161 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 159 / 255.0, green: 159 / 255.0, blue: 159 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 132 / 255.0, green: 132 / 255.0, blue: 132 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 132 / 255.0, green: 132 / 255.0, blue: 132 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 132 / 255.0, green: 132 / 255.0, blue: 132 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 132 / 255.0, green: 132 / 255.0, blue: 132 / 255.0, alpha: 1)
			}
		}
	}

	open class var videoTitleViewBGColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.68)
				case .uncDark: return UIColor(red: 10 / 255.0, green: 12 / 255.0, blue: 20 / 255.0, alpha: 0.60)
				case .mississippiLight: return UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.68)
				case .uncLight: return UIColor(red: 46 / 255.0, green: 51 / 255.0, blue: 86 / 255.0, alpha: 0.60)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.68)
			case .unc: return UIColor(red: 46 / 255.0, green: 51 / 255.0, blue: 86 / 255.0, alpha: 0.60)
			}
		}
	}

	open class var videoTitleColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 150 / 255.0, green: 183 / 255.0, blue: 54 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 150 / 255.0, green: 183 / 255.0, blue: 54 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 150 / 255.0, green: 183 / 255.0, blue: 54 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
			}
		}
	}

	/// Visit_NC_College
	open class var visitNCListCellBGColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 30 / 255.0, green: 30 / 255.0, blue: 30 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 30 / 255.0, green: 30 / 255.0, blue: 30 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
			}
		}
	}

	open class var visitNCListTitleColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 219 / 255.0, green: 219 / 255.0, blue: 219 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 9 / 255.0, green: 59 / 255.0, blue: 49 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 29 / 255.0, green: 29 / 255.0, blue: 29 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 9 / 255.0, green: 59 / 255.0, blue: 49 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 29 / 255.0, green: 29 / 255.0, blue: 29 / 255.0, alpha: 1)
			}
		}
	}

	open class var visitNCListTagBGColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.clear
				case .uncDark: return UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor.clear
				case .uncLight: return UIColor(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.clear
			case .unc: return UIColor(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0, alpha: 1)
			}
		}
	}

	open class var visitNCListTagBorderColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 214 / 255.0, green: 214 / 255.0, blue: 214 / 255.0, alpha: 1)
				case .uncDark: return UIColor.clear
				case .mississippiLight: return UIColor(red: 214 / 255.0, green: 214 / 255.0, blue: 214 / 255.0, alpha: 1)
				case .uncLight: return UIColor.clear
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 214 / 255.0, green: 214 / 255.0, blue: 214 / 255.0, alpha: 1)
			case .unc: return UIColor.clear
			}
		}
	}

	open class var visitNCListTagTextColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 207 / 255.0, green: 207 / 255.0, blue: 207 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 161 / 255.0, green: 161 / 255.0, blue: 161 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 68 / 255.0, green: 68 / 255.0, blue: 68 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 29 / 255.0, green: 29 / 255.0, blue: 29 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 68 / 255.0, green: 68 / 255.0, blue: 68 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 29 / 255.0, green: 29 / 255.0, blue: 29 / 255.0, alpha: 1)
			}
		}
	}

	open class var visitNCListLineSeperatorColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 168 / 255.0, green: 168 / 255.0, blue: 168 / 255.0, alpha: 0.15)
				case .uncDark: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.15)
				case .mississippiLight: return UIColor(red: 168 / 255.0, green: 168 / 255.0, blue: 168 / 255.0, alpha: 0.15)
				case .uncLight: return UIColor(red: 112 / 255.0, green: 112 / 255.0, blue: 112 / 255.0, alpha: 0.15)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 168 / 255.0, green: 168 / 255.0, blue: 168 / 255.0, alpha: 0.15)
			case .unc: return UIColor(red: 112 / 255.0, green: 112 / 255.0, blue: 112 / 255.0, alpha: 0.15)
			}
		}
	}

	open class var visitNCSelectedSegmentTintColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 25 / 255.0, green: 134 / 255.0, blue: 189 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 54 / 255.0, green: 147 / 255.0, blue: 255 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 25 / 255.0, green: 134 / 255.0, blue: 189 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 45 / 255.0, green: 50 / 255.0, blue: 86 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 25 / 255.0, green: 134 / 255.0, blue: 189 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 45 / 255.0, green: 50 / 255.0, blue: 86 / 255.0, alpha: 1)
			}
		}
	}

	open class var visitNCSegmentBGColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 71 / 255.0, green: 71 / 255.0, blue: 71 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
			}
		}
	}

	open class var visitNCSegmentSelectedTextColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1)
			}
		}
	}

	open class var visitNCSegmentNormalTextColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 212 / 255.0, green: 212 / 255.0, blue: 212 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 172 / 255.0, green: 173 / 255.0, blue: 184 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 172 / 255.0, green: 173 / 255.0, blue: 184 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 172 / 255.0, green: 173 / 255.0, blue: 184 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 172 / 255.0, green: 173 / 255.0, blue: 184 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 172 / 255.0, green: 173 / 255.0, blue: 184 / 255.0, alpha: 1)
			}
		}
	}

	open class var ncCollegeRowImageBorderColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1)
			}
		}
	}

	/// College_detail_page
	open class var collegeDetailPageBGColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
			}
		}
	}

	open class var webViewBGColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
			}
		}
	}

	open class var collegeDetailPageLineSeperatorColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.clear
				case .uncDark: return UIColor.clear
				case .mississippiLight: return UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1)
			}
		}
	}

	open class var collegeDetailPageTagBGColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 51 / 255.0, green: 44 / 255.0, blue: 44 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 55 / 255.0, green: 55 / 255.0, blue: 55 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0, alpha: 1)
			}
		}
	}

	open class var collegeDetailPageTagTextColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 213 / 255.0, green: 213 / 255.0, blue: 213 / 255.0, alpha: 1)
				case .uncDark: return UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1)
				case .mississippiLight: return UIColor(red: 68 / 255.0, green: 68 / 255.0, blue: 68 / 255.0, alpha: 1)
				case .uncLight: return UIColor(red: 68 / 255.0, green: 68 / 255.0, blue: 68 / 255.0, alpha: 1)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 68 / 255.0, green: 68 / 255.0, blue: 68 / 255.0, alpha: 1)
			case .unc: return UIColor(red: 68 / 255.0, green: 68 / 255.0, blue: 68 / 255.0, alpha: 1)
			}
		}
	}

	open class var collegeDetailPageTagBorderColor: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor.clear
				case .uncDark: return UIColor.clear
				case .mississippiLight: return UIColor.clear
				case .uncLight: return UIColor.clear
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor.clear
			case .unc: return UIColor.clear
			}
		}
	}

    open class var contentDetailsBgColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (_) -> UIColor in
                // Return one of two colors depending on light or dark mode
                switch config.theme {
                case .mississippiDark: return UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
                case .uncDark: return UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
                case .mississippiLight: return UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1.0)
                case .uncLight: return UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1.0)
                }
            }
        } else {
            // Same old color used for iOS 12 and earlier
            switch config.university {
            case .mississippi: return UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1.0)
            case .unc: return UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1.0)
            }
        }
    }

	open class var activityIndicator: UIColor {
		if #available(iOS 13.0, *) {
			return UIColor { (_) -> UIColor in
				// Return one of two colors depending on light or dark mode
				switch config.theme {
				case .mississippiDark: return UIColor(red: 0.85, green: 0.87, blue: 0.25, alpha: 1.0)
				case .uncDark: return UIColor(red: 0.85, green: 0.87, blue: 0.25, alpha: 1.0)
				case .mississippiLight: return UIColor(red: 0.85, green: 0.87, blue: 0.25, alpha: 1.0)
				case .uncLight: return UIColor(red: 0.85, green: 0.87, blue: 0.25, alpha: 1.0)
				}
			}
		} else {
			// Same old color used for iOS 12 and earlier
			switch config.university {
			case .mississippi: return UIColor(red: 0.85, green: 0.87, blue: 0.25, alpha: 1.0)
			case .unc: return UIColor(red: 0.85, green: 0.87, blue: 0.25, alpha: 1.0)
			}
		}
	}

    /// Careers
    open class var careersBgColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (_) -> UIColor in
                // Return one of two colors depending on light or dark mode
                switch config.theme {
                case .mississippiDark: return UIColor(red: 30 / 255.0, green: 30 / 255.0, blue: 30 / 255.0, alpha: 1)
                case .uncDark: return UIColor(red: 30 / 255.0, green: 30 / 255.0, blue: 30 / 255.0, alpha: 1)
                case .mississippiLight: return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
                case .uncLight: return UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
                }
            }
        } else {
            // Same old color used for iOS 12 and earlier
            switch config.university {
            case .mississippi: return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
            case .unc: return UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
            }
        }
    }

    open class var careersCellBottomBorderColor: UIColor {
           if #available(iOS 13.0, *) {
               return UIColor { (_) -> UIColor in
                   // Return one of two colors depending on light or dark mode
                   switch config.theme {
                   case .mississippiDark: return UIColor(red: 30 / 255.0, green: 30 / 255.0, blue: 30 / 255.0, alpha: 1)
                   case .uncDark: return UIColor(red: 30 / 255.0, green: 30 / 255.0, blue: 30 / 255.0, alpha: 1)
                   case .mississippiLight: return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
                   case .uncLight: return UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
                   }
               }
           } else {
               // Same old color used for iOS 12 and earlier
               switch config.university {
               case .mississippi: return UIColor(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
               case .unc: return UIColor(red: 246 / 255.0, green: 246 / 255.0, blue: 246 / 255.0, alpha: 1)
               }
           }
       }

    open class var careersCellTextColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (_) -> UIColor in
                // Return one of two colors depending on light or dark mode
                switch config.theme {
                case .mississippiDark: return UIColor(red: 232 / 255.0, green: 232 / 255.0, blue: 232 / 255.0, alpha: 1)
                case .uncDark: return UIColor(red: 232 / 255.0, green: 232 / 255.0, blue: 232 / 255.0, alpha: 1)
                case .mississippiLight: return UIColor.black
                case .uncLight: return UIColor.black
                }
            }
        } else {
            // Same old color used for iOS 12 and earlier
            switch config.university {
            case .mississippi: return UIColor.black
            case .unc: return UIColor.black
            }
        }
    }

    open class var careersCellImageBorderColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (_) -> UIColor in
                // Return one of two colors depending on light or dark mode
                switch config.theme {
                case .mississippiDark: return UIColor(red: 27 / 255.0, green: 134 / 255.0, blue: 191 / 255.0, alpha: 1)
                case .uncDark: return UIColor(red: 54 / 255.0, green: 147 / 255.0, blue: 255 / 255.0, alpha: 1)
                case .mississippiLight: return UIColor(red: 0 / 255.0, green: 39 / 255.0, blue: 80 / 255.0, alpha: 1)
                case .uncLight: return UIColor(red: 0 / 255.0, green: 39 / 255.0, blue: 80 / 255.0, alpha: 1)
                }
            }
        } else {
            // Same old color used for iOS 12 and earlier
            switch config.university {
            case .mississippi: return UIColor(red: 0 / 255.0, green: 39 / 255.0, blue: 80 / 255.0, alpha: 1)
            case .unc: return UIColor(red: 0 / 255.0, green: 39 / 255.0, blue: 80 / 255.0, alpha: 1)
            }
        }
    }

    open class var careersCellBgColor: UIColor {
           if #available(iOS 13.0, *) {
               return UIColor { (_) -> UIColor in
                   // Return one of two colors depending on light or dark mode
                   switch config.theme {
                   case .mississippiDark: return UIColor(red: 33 / 255.0, green: 33 / 255.0, blue: 33 / 255.0, alpha: 1)
                   case .uncDark: return UIColor(red: 38 / 255.0, green: 38 / 255.0, blue: 38 / 255.0, alpha: 1)
                   case .mississippiLight: return UIColor.white
                   case .uncLight: return UIColor.white
                   }
               }
           } else {
               // Same old color used for iOS 12 and earlier
               switch config.university {
               case .mississippi: return UIColor.white
               case .unc: return UIColor.white
               }
           }
       }

}
