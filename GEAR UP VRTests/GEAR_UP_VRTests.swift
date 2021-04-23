//
//  GEAR_UP_VRTests.swift
//  GEAR UP VRTests
//
//  Created by Shineeth Hamza on 23/09/19.
//  Copyright © 2019 Shineeth Hamza. All rights reserved.
//

import XCTest
import KeychainSwift

@testable import GEAR_UP_VR

class GEAR_UP_VRTests: XCTestCase {

    var analyticsService: AnalyticsService?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        //let body = ["name":""]
        //stub(https(.post, uri: "https://3.92.10.6/api/schools/")), json(body))

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    /// This unit test method is to test the Silent login API and associated functionalities.
    func testSilentLoginAPIPerformance() {
       let expectation  = self.expectation(description: "Fetch user types data from api")
        let api = APIRequest()

             api.authenticateUser { (accessToken, _) in

                if let accessToken = KeychainSwift().get(Key.accessToken.rawValue) {

                    XCTAssertGreaterThan(accessToken.count, 0)
                } else {
                    XCTFail("Unable to find Access token in the keychain")
                }
                 expectation.fulfill()
        }
          waitForExpectations(timeout: 60, handler: nil)
    }

    func testFetchUserTypeFunctionalityPerformance() {

       let expectation  = self.expectation(description: "Fetch user types data from api")

        self.analyticsService  = AnalyticsService()

        self.analyticsService!.fetchUserTypes { (types, _) in

          if let userTypes = types {
                if userTypes.count == 0 {
              XCTFail("Unable to obtain any user type from the Service")
                } else {
                    for userType in userTypes {
                        if userType.uid.count == 0 {
                     XCTFail("Unable to find user type id")
                        }
                    }
                    XCTAssertGreaterThan(userTypes.count, 0)
                }
          } else {
                XCTFail("Unable to obtain any user type from the Service")
            }

                expectation.fulfill()
        }

          waitForExpectations(timeout: 60, handler: nil)

    }
        func testFetchHighSchoolsPerformance() {

            let expectation  = self.expectation(description: "Fetch school data from api")

             self.analyticsService = AnalyticsService()

            self.analyticsService!.fetchHighSchools(query: "chin") {(results, error, _) in

                if error != nil {
                    XCTFail("Error obtained as response while invoking high school api")
                } else {
                    if let schools = results {
                        let arr = schools.filter {
                            ($0.name.contains("chin") == false) && ($0.name.contains("Chin") == false)
                         }

                        if schools.count > 0 && arr.count>0 {
                             XCTFail("Response array contains items which do not contain the queried keyword")
                        } else {
                            XCTAssert(true)
                        }
                    } else {
                        XCTFail("Result obtained is null")
                    }
                }

                 expectation.fulfill()

            }

             waitForExpectations(timeout: 60, handler: nil)

    }

    func testSubmitUserAnalytics() {

        let expectation  = self.expectation(description: "submit analytics data to the api")

         self.analyticsService = AnalyticsService()

        let user = UserTypeElement(uid: "2bb79fc0-0c5a-4808-8a06-156013341fcd", title: "Student")

        let school = School(uid: "42bbbcf1-b332-411d-8a6a-9d1881c3cb0a", name: "Chinmaya Vidyalaya")

        self.analyticsService!.submitUserAnalytics(deviceId: "DFF00276-3AB7-45A2-AFB5-E839E131B562", userType: user, school: school ) { (acknowledgment, error) in

            if error != nil {
                XCTFail("Error obtained as response while submiting anaytics data to the server. Error code:")
            } else {
                if acknowledgment == true {
                    XCTAssert(true)
                } else {
                    XCTFail("Error obtained as response  while submiting anaytics data to the server. Error code:")
                }
            }

             expectation.fulfill()
        }
          waitForExpectations(timeout: 60, handler: nil)

    }

}
