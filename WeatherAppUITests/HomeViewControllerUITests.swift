//
//  HomeViewControllerUITests.swift
//  WeatherAppUITests
//
//  Created by Gaurish Salunke on 6/19/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import XCTest
@testable import WeatherApp

class HomeViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTableViewCellExists() {
        
        // Assert that we are displaying the tableview
        let cityTableView = app.tables.matching(identifier: "table-cityTableView")
                
        // Get an array of cells
        let tableCells = cityTableView.cells
        
        if tableCells.count > 0 {
            let count: Int = (tableCells.count - 1)
            
            let promise = expectation(description: "Wait for table cells")
            
            for i in stride(from: 0, to: count , by: 1) {
                // Grab the first cell and verify that it exists and tap it
                let tableCell = tableCells.element(boundBy: i)
                XCTAssertTrue(tableCell.exists, "The \(i) cell is in place on the table")
                // Does this actually take us to the next screen
                tableCell.tap()
                
                if i == (count - 1) {
                    promise.fulfill()
                }
                // Back
                app.buttons.firstMatch.tap()
            }
            waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
            
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }
        
    func testTableCellHasCorrectValue() {
        let exp = expectation(description: "Test after 3 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 3.0)
        if result == XCTWaiter.Result.timedOut {
            let cityTableView = app.tables.matching(identifier: "table-cityTableView")
            let firstCell = cityTableView.cells.element(matching: .cell, identifier: "CityWeatherCell_0")

            XCTAssertTrue(firstCell.staticTexts.element(boundBy: 1).exists, "Test Case Failed: local time label doesn't exists.")
            
            XCTAssertEqual(firstCell.staticTexts.element(boundBy: 1).label, "Melbourne")
            
            XCTAssertTrue(firstCell.staticTexts.element(boundBy: 2).exists, "Test Case Failed: temperature label doesn't exists.")
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testTemperatureConvertedToFahrenheitSuccessfully() {
        let exp = expectation(description: "Test after 3 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 3.0)
        if result == XCTWaiter.Result.timedOut {
            let cityTableView = app.tables.matching(identifier: "table-cityTableView")
            let firstCell = cityTableView.cells.element(matching: .cell, identifier: "CityWeatherCell_0")

            let footerCell = cityTableView.cells.element(matching: .cell, identifier: "FooterCell_0")
            // make sure the celsius option is selected.
            footerCell.buttons.element(boundBy: 0).tap()

            let temperatureInCelsiusLabel = firstCell.staticTexts.element(boundBy: 2).label
            let temperatureInCelsius = Double(temperatureInCelsiusLabel.dropLast())
                
            let fahrenheitValue = (temperatureInCelsius! * (9/5)) + 32
            let fahrenheitValueStr = String(format: "%.0f%@", fahrenheitValue, "\u{00B0}")
            print("fahrenheitValue: \(fahrenheitValue) fahrenheitValueStr: \(fahrenheitValueStr)")
            
            // now select the fahrenheit option
            footerCell.buttons.element(boundBy: 1).tap()
            
            let temperatureInFahrenheitLabel = firstCell.staticTexts.element(boundBy: 2).label
            
            XCTAssertEqual(temperatureInFahrenheitLabel, fahrenheitValueStr)
            
            // reverting the degree option to celsius
            footerCell.buttons.element(boundBy: 0).tap()
        } else {
            XCTFail("Delay interrupted")
        }
    }
}


//Weather(id: 2158177, dt: 1590066544, name: "Melbourne", coord: Coord(lat: 153.03, lon: -27.47), sys: Sys(timezone: 36000, sunrise: 1590009515, sunset: 1590045313), weather: [WeatherData(id: 804, main: "Clouds", description: "overcast clouds", icon: "04n")], main: Main(temp: 10.17, feelsLike: 6.16, tempMin: 8.33, tempMax: 12.78, pressure: 1020, humidity: 87), wind: Wind(speed: 4.6), clouds: Cloud(all: 100)),
