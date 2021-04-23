//
//  CareerDetails.swift
//  GEAR UP VR
//
//  Created by Ansarsha on 29/04/20.
//  Copyright © 2020 Marlabs Inc. All rights reserved.
//

import Foundation
// MARK: - CareerDetails
struct CareerDetails: Codable {
    let uid: String
    let video: Video?
    let logo: String?
    let darkModeContent, lightModeContent, career: String?
    let email, phoneNumber, facebookURL, twitterURL: String?
    let linkedinURL, instagramURL, website: String?

    enum CodingKeys: String, CodingKey {
        case uid, video, logo
        case darkModeContent = "dark_mode_content"
        case lightModeContent = "light_mode_content"
        case career, email
        case phoneNumber = "phone_number"
        case facebookURL = "facebook_url"
        case twitterURL = "twitter_url"
        case linkedinURL = "linkedin_url"
        case instagramURL = "instagram_url"
        case website
    }
}
