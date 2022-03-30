//
//  ViewControllerTests.swift
//  20220328-KranthiKumarVodapelli-NYCSchoolsTests
//
//  Created by Kranthi Vodapelli on 3/29/22.
//

import XCTest
@testable import _0220328_KranthiKumarVodapelli_NYCSchools

class ViewControllerTests: XCTestCase {

    var schoolController: SchoolsViewController?
    var detailViewController: SchoolDetailsViewController?

    override func setUpWithError() throws {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let controller = storyBoard.instantiateViewController(withIdentifier: "SchoolsViewControllerID") as? SchoolsViewController {
            controller.loadViewIfNeeded()
            schoolController = controller
        }
    }
    
    override func tearDownWithError() throws {
        schoolController = nil
        detailViewController = nil
    }
    
    func testSchoolControlelr() throws {
        XCTAssertNotNil(schoolController)
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

        let expectation2 = XCTestExpectation(description: "load tableview")

        schoolController?.listViewModel = listViewModel
        schoolController?.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            expectation2.fulfill()
        }
        self.wait(for: [expectation2], timeout: 5)
    }
        
    func testDetailController() throws {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let controller = storyBoard.instantiateViewController(withIdentifier: "SchoolDetailsViewControllerID") as? SchoolDetailsViewController {
            detailViewController = controller
            controller.school = TestUtility.getSchoolModel(dbn: "01M292")
            XCTAssertNotNil(detailViewController?.view)
            detailViewController?.viewDidLoad()

            let expectation = XCTestExpectation(description: "load view")
            detailViewController?.detailTableView.reloadData()

            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                expectation.fulfill()
            }
            self.wait(for: [expectation], timeout: 6)
            detailViewController?.handleUrl(scheme: "https", url: "www.google.com")
        }
    }
    func testUtility() {
        if let schoolController = schoolController {
           XCTAssertNoThrow(Utility.open(scheme: "telprompt", urlString: "", contoller: schoolController))
            XCTAssertNoThrow(Utility.open(scheme: "https", urlString: "www.google.com", contoller: schoolController))
        }
    }

}
