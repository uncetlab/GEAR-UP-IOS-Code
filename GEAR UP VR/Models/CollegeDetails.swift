//
//  CollegeDetails.swift
//  GEAR UP VR
//
//  Created by Ansarsha on 21/01/20.
//  Copyright © 2020 Shineeth Hamza. All rights reserved.
//

import Foundation

// MARK: - CollegeDetails

struct CollegeDetails: Codable {
    let uid: String?
    let video: Video?
    let tiles: [String]?
    let logo: String?
    let location: Location?
    let majors: [Major]
    let darkModeContent, lightModeContent, name, shortName, email: String?
    let studentCapacity: Int
    let phoneNumber, facebookURL, twitterURL, linkedinURL: String?
    let website: String?
    let tags: String?
    let inStateSatScore, inStateActScore, inStateCostPerYear, outStateSatScore: Int
    let outStateActScore, outStateCostPerYear: Int
    let disabilityAccess: Bool
    let disabilityAccessURL: String?
    let address: String?
    let active: Bool?
    let university: String?

    enum CodingKeys: String, CodingKey {
        case uid, video, tiles, logo, location, majors, name, active, university
        case shortName = "short_name"
        case darkModeContent = "dark_mode_content"
        case lightModeContent = "light_mode_content"
        case email
        case studentCapacity = "student_capacity"
        case phoneNumber = "phone_number"
        case facebookURL = "facebook_url"
        case twitterURL = "twitter_url"
        case linkedinURL = "linkedin_url"
        case website, tags
        case inStateSatScore = "in_state_sat_score"
        case inStateActScore = "in_state_act_score"
        case inStateCostPerYear = "in_state_cost_per_year"
        case outStateSatScore = "out_state_sat_score"
        case outStateActScore = "out_state_act_score"
        case outStateCostPerYear = "out_state_cost_per_year"
        case disabilityAccess = "disability_access"
        case disabilityAccessURL = "disability_access_url"
        case address
    }
}
