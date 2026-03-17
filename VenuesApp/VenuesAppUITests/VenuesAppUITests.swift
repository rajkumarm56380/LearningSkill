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
        let app = XCUIApplication()
        app.activate()
        let element = app.scrollViews/*@START_MENU_TOKEN@*/.firstMatch/*[[".containing(.other, identifier: nil).firstMatch",".firstMatch"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        element.tap()
        app.staticTexts["\"Super delicious authentic coffee.\""].firstMatch.tap()
        XCTAssertTrue(app.waitForExistence(timeout: 5))
    }

    func testLoadingIndicator() {
        let app = XCUIApplication()
        app.launch()
        app.launchArguments = ["-mockMode"]
        XCTAssertTrue(app.activityIndicators.firstMatch.exists)
    }
}
