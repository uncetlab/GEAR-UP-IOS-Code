//
//  Constants.swift
//  GEAR UP VR
//
//  Created by Harikrishnan on 30/09/2019.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import Foundation
import UIKit

enum Key: String {
    case accessToken
    case isAnalyticsSubmited
}

enum HTTPMethod: String {
    case POST
    case PUT
    case GET
    case DELETE
}

struct FilterConstants {
    static let stateTypeIn: String = "in_state"
    static let stateTypeOut: String = "out_state"
    static let satScoreMinimum: Float = 400
    static let satScoreMaximum: Float = 1600
    static let actScoreMinimum: Float = 1
    static let actScoreMaximum: Float = 36
    static let studentCapacityMinimum: Int = 0
    static let studentCapacityMaximum: Int = 4999
    static let costPerYearMinimum: Float = 500
    static let costPerYearMaximum: Float = 70000
    static let limit: Int = 10
}

struct WebViewAlert {
    static let message: String = "Open"
    static let inAppBrowser: String = "Within the application"
    static let externalBrowser: String = "Outside the application"
}

struct ErrorMessages {
    static let emailNotConfigured: String = "Email app is unavailable. Please check email is configured on the phone settings."
    static let messageNotConfigured: String = "SMS app is unavailable. Please check SMS is configured on the phone settings."
    static let facebookNotConfigured: String = "Facebook app is unavailable. Please check Facebook is configured on the phone settings."
    static let linkdinNotConfigured: String = "Linkdin app is unavailable. Please check Linkdin is configured on the phone settings."
    static let instagramNotConfigured: String = "Instagram app is unavailable. Please check Instagram is configured on the phone settings."
    static let youtubeNotConfigured: String = "Youtube app is unavailable. Please check Youtube is configured on the phone settings."

    static let twitterNotConfigured: String = "Twitter app is unavailable. Please check Twitter is configured on the phone settings."
    static let errorToLoadScreen: String = "Unable to load screen."
    static let errorToLoadURL: String = "Unable to open The URL."

    static let InactiveUserInfo: String = "It looks like you may be using an older version of app. Please update the app and retry or contact support team at "

    static let InactiveUniversityInfo: String = "Please contact support team at "

     static let genericErrorInfo: String = "There is an error while fetching data. Please retry or contact support team at "
}

struct CurrentTheme {
    static let name: String = "APPCurrentTheme"
}

struct PageType {
    static let external: String = "external"
    static let custom: String = "native"
    static let builtIn: String = "pre_defined"
}

let satScoreTitle: String = "SAT Score"
let actScoreTitle: String = "ACT Score"
let costPerYearTitle: String = "Cost per year"
let filterBy: String = "Filter by"
