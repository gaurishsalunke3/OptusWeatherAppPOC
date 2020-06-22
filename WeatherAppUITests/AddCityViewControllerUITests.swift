//
//  AddCityViewControllerUITests.swift
//  WeatherAppUITests
//
//  Created by Gaurish Salunke on 6/22/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import XCTest

class AddCityViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    func testAddCityHasValidTableView() {
        
        app.tables.buttons["plus.circle"].tap()

        let addCityTableView = app.tables.matching(identifier: "table-addCityTableView")
        let firstCell = addCityTableView.cells.element(matching: .cell, identifier: "NewCityCell_0")
        let predicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: predicate, evaluatedWith: firstCell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 3.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Test Case Failed: Table View doesn't exists")                        
    }
    
    func testSearchCityHAsValidResults() {
        app.tables.buttons["plus.circle"].tap()

        let addCityTableView = app.tables.matching(identifier: "table-addCityTableView")

        let exp = expectation(description: "Test after 3 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 3.0)
        if result == XCTWaiter.Result.timedOut {
            app.textFields["Search city name"].tap()
            let searchBar = app.textFields["Search city name"]
            searchBar.typeText("Pune")

            let firstCell = addCityTableView.cells.element(matching: .cell, identifier: "NewCityCell_0")

            XCTAssertTrue(firstCell.exists, "Test Case Failed: No results returned")
            XCTAssertTrue(firstCell.staticTexts["Pune, IN"].exists, "Test Case Failed: No results returned")
        } else {
            XCTFail("Delay interrupted")
        }
    }
}
