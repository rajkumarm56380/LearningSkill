//
//  DemoLocationAppUITests.swift
//  DemoLocationAppUITests
//
//  Created by user on 18/03/26.
//

import XCTest

final class DemoLocationAppUITests: XCTestCase {

    var app: XCUIApplication!

        override func setUp() {
            super.setUp()

            continueAfterFailure = false
            app = XCUIApplication()
            app.launch()
            app.launchArguments = ["UI_TEST_MODE"]
        }

        // MARK: 1. App Launch
        func test_appLaunchesSuccessfully() {
            XCTAssertTrue(app.otherElements["mapView"].exists)
        }


        // MARK: 2. Long Press Adds Pin
        func test_longPress_addsPin() {

            let map = app.otherElements["mapView"]

            map.press(forDuration: 1.0)

            let pin = app.images["map_pin"]
            XCTAssertTrue(pin.waitForExistence(timeout: 2))
        }


        // MARK: 3. Multiple Pins
        func test_multiplePins_added() {

            let map = app.otherElements["mapView"]

            map.tap()
            map.tap()
            map.tap()

            let pins = app.images.matching(identifier: "map_pin")

            XCTAssertTrue(pins.count >= 1)
        }

        // MARK: 4. Performance Test
        func test_mapPerformance() {

            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
}
