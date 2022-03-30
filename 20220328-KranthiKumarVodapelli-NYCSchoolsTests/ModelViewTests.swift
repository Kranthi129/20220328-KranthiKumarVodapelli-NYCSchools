//
//  ModelViewTests.swift
//  20220328-KranthiKumarVodapelli-NYCSchoolsTests
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import XCTest
@testable import _0220328_KranthiKumarVodapelli_NYCSchools

class ModelViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDetailViewModelTests() {
        let myurlSession = MyNYCSessionSuccessProtocol(name: "details")
        let networkManager = NetworkManager(urlSession: myurlSession)
        let detailViewModel = DetailsViewModel()
        let expectation = XCTestExpectation(description: "wait for url response")

        if let school = TestUtility.getSchoolModel(dbn: "01M292"){
            detailViewModel.getDetails(networkManager: networkManager, school: school) { (response: [Scores]?, error) in
                expectation.fulfill()
                XCTAssertNotNil(response)
                let score = response?.first
                XCTAssertNotNil(score)
                XCTAssertEqual(score?.dbn, school.dbn)
            }
        }
    }
    
    func testDetailViewModelErrorTests() {
        let myurlSession = MyNYCSessionSuccessProtocol(name: "details")
        let networkManager = NetworkManager(urlSession: myurlSession)
        let detailViewModel = DetailsViewModel()
        let expectation = XCTestExpectation(description: "wait for url response")

        if let school = TestUtility.getSchoolModel(dbn: "01M2432"){
            detailViewModel.getDetails(networkManager: networkManager, school: school) { (response: [Scores]?, error) in
                expectation.fulfill()
                XCTAssertNil(response)
            }
        }
    }

    
    func testListViewModelTests() {
        
        let myurlSession = MyNYCSessionSuccessProtocol(name: "schools")
        let networkManager = NetworkManager(urlSession: myurlSession)
        let listViewModel = ListViewModel()
        let expectation = XCTestExpectation(description: "wait for url response")
        listViewModel.fetchSchoolsData(networkManager: networkManager) { error in
            expectation.fulfill()
            XCTAssertNotNil(listViewModel.schools)
            XCTAssertNotNil(listViewModel.filteredSchools)
            XCTAssertNotNil(listViewModel.filterSchools(searchText:"A"))
        }
        self.wait(for: [expectation], timeout: 1)

    }
}
