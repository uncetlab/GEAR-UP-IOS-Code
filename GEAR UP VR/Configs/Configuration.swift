//
//  Configuration.swift
//  GEAR UP VR
//
//  Created by Shineeth Hamza on 24/09/19.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation
import UIKit

enum Environment: String {
    case development
    case qa = "QA"
    case uat = "UAT"
    case production
}

enum APIStatusCode: String {
    case invalidUniversity
    case invalidUser
    case genericError
}

enum University: String {
    case mississippi
    case unc
}

enum Theme: String {
    case mississippiDark
    case mississippiLight
    case uncDark
    case uncLight
}

struct Configuration {
    public var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            // if univer
            if configuration.range(of: "Production") != nil {
                return Environment.production
            } else if configuration.range(of: "QA") != nil {
                return Environment.qa
            } else if configuration.range(of: "UAT") != nil {
                return Environment.uat
            }
        }
        return Environment.development
    }()

    var university: University = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.range(of: "mississippi".capitalized) != nil {
                return University.mississippi
            }
        }
        return University.unc
    }()

    public var theme: Theme {
        switch university {
        case .mississippi: if #available(iOS 12.0, *) {
            return UIScreen.main.traitCollection.userInterfaceStyle == .dark ? Theme.mississippiDark : Theme.mississippiLight
        } else {
            return Theme.mississippiLight
        }
        case .unc: if #available(iOS 12.0, *) {
            return UIScreen.main.traitCollection.userInterfaceStyle == .dark ? Theme.uncDark : Theme.uncLight
        } else {
            return Theme.uncLight
        }
        }
    }

    public var darkMode: Bool {
        if #available(iOS 12.0, *) {
            return UIScreen.main.traitCollection.userInterfaceStyle == .dark ? true : false
        }
            return false
    }

    public var contactEmail: String {
        switch university {
        case .mississippi: return "reeseinnovate@gmail.com"
        case .unc: return "reeseinnovate@gmail.com"
        }
    }

    var baseURL: String {
        switch environment {
        case .development: return "https://dev.uncgearup.xyz/"
        case .qa: return "https://qa.uncgearup.xyz/"
        case .uat: return "https://uat.uncgearup.xyz/"
        case .production: return "https://api.gearupapp.org/"
        }
    }

	var appCenterKey: String {
		switch environment {
			case .production:
				switch university {
					case .unc: return "29fbfa93-727f-42fb-8765-d61bed0d6fb5"
					case .mississippi: return "96941eab-254a-48ab-9a0e-67f4028d30c3"
			}
			case .uat:
				switch university {
					case .unc: return "29fbfa93-727f-42fb-8765-d61bed0d6fb5"
					case .mississippi: return "cac60221-2b2e-4bc5-977f-c2baf4d32836"
			}
			default:
				return "d223b805-5c78-413f-9ff9-02880bf4e361"
		}
	}

    private let _usernames: [University: [Environment: String]] = [University.mississippi: [Environment.development: "mississippi",
                                                                                            Environment.qa: "mississippi",
                                                                                            Environment.uat: "mississippi",
                                                                                            Environment.production: "0rer-vcea"],
                                                                   University.unc: [Environment.development: "rdc3-r8q5",
                                                                                    Environment.qa: "device_user",
                                                                                    Environment.uat: "device_user",
                                                                                    Environment.production: "ewbs-yzbg"]]
    var username: String {
        return _usernames[university]?[environment] ?? ""
    }

    private let _passwords: [University: [Environment: String]] = [University.mississippi: [Environment.development: "gearup@123",
                                                                                            Environment.qa: "gearup@123",
                                                                                            Environment.uat: "gearup@123",
                                                                                            Environment.production: "cm2nucolok512e39"],
                                                                   University.unc: [Environment.development: "o4zey1yeukm2bnk9",
                                                                                    Environment.qa: "gearup@123",
                                                                                    Environment.uat: "gearup@123",
                                                                                    Environment.production: "xkfhb9jybc0ucbdc"]]
    var password: String {
        return _passwords[university]?[environment] ?? ""
    }
}
