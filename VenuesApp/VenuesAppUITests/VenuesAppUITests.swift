//
//  VenuesAppUITests.swift
//  VenuesAppUITests
//
//

import XCTest

final class VenuesAppUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        app.launchArguments = ["-mockMode"]
        
    }

    func testVenueListLoads() {
        let firstCell = app.staticTexts["Venue Name"]
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
    }

    func testLoadingIndicator() {
        let app = XCUIApplication()
        app.launch()
        app.launchArguments = ["-mockMode"]
        XCTAssertTrue(app.activityIndicators.firstMatch.exists)
    }
}
