//
//  EnvironmentsTests.swift
//  20220328-KranthiKumarVodapelli-NYCSchoolsTests
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import XCTest
@testable import _0220328_KranthiKumarVodapelli_NYCSchools

class EnvironmentsTests: XCTestCase {

    func testEnvironment() {
        XCTAssertEqual(Environment.baseURL.absoluteString, "https://data.cityofnewyork.us")
        XCTAssertEqual(Environment.rootURLstring, Environment.baseURL.absoluteString)
        XCTAssertEqual(Environment.schoolDirectoryURL.path, "/resource/s3k6-pzi2.json")
        XCTAssertEqual(Environment.getResultURL(dbn: "123").path, "/resource/f9bf-2cp4.json")
    }

}
