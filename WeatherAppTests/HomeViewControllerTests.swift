//
//  HomeViewControllerTests.swift
//  WeatherAppTests
//
//  Created by Gaurish Salunke on 6/19/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import XCTest
@testable import WeatherApp

class HomeViewControllerTests: XCTestCase {

    var viewController: HomeViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = (storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController)
        
        self.viewController.loadView()
        self.viewController.viewDidLoad()
    }

    override func tearDownWithError() throws {
    }

    // test to check if the viewcontroller has a tableview
    func testHasATableView() {
        XCTAssertNotNil(viewController.cityTableView)
    }
    
    // test to check if the tableview has a valid delegate assigned to it.
    func testTableViewHAsDelegate() {
        XCTAssertNotNil(viewController.cityTableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocols() {
        XCTAssertTrue(viewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewController.cityTableView.dataSource)
    }

    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier() {
        let cell = viewController.tableView(viewController.cityTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! FooterCellView
        let actualReuseIdentifer = cell.reuseIdentifier
        let expectedReuseIdentifier = "FooterCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func testTableCellHasCorrectValue() {
        let exp = expectation(description: "Test after 3 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 3.0)
        if result == XCTWaiter.Result.timedOut {
            let cell = viewController.tableView(viewController.cityTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! CityWeatherCellView
            XCTAssertEqual(cell.cityNameLabel.text, "Melbourne")
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
