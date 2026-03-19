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
        app.launchArguments = ["UI_TEST_MODE"]
        app.launch()
    }

    func test_mapView_isLoaded() {
        let mapView = app.otherElements["mapView"]
        XCTAssertTrue(mapView.waitForExistence(timeout: 3))
    }

    func test_currentLocationPin_isAdded() {
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST_MODE")
        app.launch()
        let pin = app.otherElements["map_pin"]
        let exists = pin.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Pin not added after location update")
    }

    func test_annotation_isAdded_afterLocationFetched() {
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST_MODE")
        app.launch()
        let pins = app.otherElements.matching(NSPredicate(format: "identifier == 'map_pin'"))
        XCTAssertTrue(pins.count > 0)
    }

    func test_map_and_pin_isAdded_afterLocationFetched() {
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST_MODE")
        app.launch()

        // 1. Map loaded
        let map = app.otherElements["mapView"]
        XCTAssertTrue(map.waitForExistence(timeout: 3))

        // 2. Pin added
        let pin = app.otherElements["map_pin"]
        XCTAssertTrue(pin.waitForExistence(timeout: 5))
    }

    func test_multiplePins_added() {
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST_MODE")
        app.launch()
        
        let pin = app.otherElements["map_pin"]
        XCTAssertTrue(pin.waitForExistence(timeout: 5))

        app.otherElements["AnnotationContainer"].firstMatch.tap()
        app.otherElements["AnnotationContainer"].firstMatch.tap()
        app.otherElements["AnnotationContainer"].firstMatch.tap()

        let annotation = app.otherElements["AnnotationContainer"]
        XCTAssertTrue(annotation.waitForExistence(timeout: 5))
        let map_pinCount = app.otherElements.matching(NSPredicate(format: "identifier == 'map_pin'"))
        XCTAssertTrue(map_pinCount.count > 2)
    }

    func test_multiplePins_areAdded() {
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST_MODE")
        app.launch()

        let pins = app.otherElements.matching(identifier: "map_pin")

        let predicate = NSPredicate(format: "count == 3")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: pins)

        let result = XCTWaiter().wait(for: [expectation], timeout: 5)

        XCTAssertEqual(result, .completed, "Expected 3 pins, but not found")
    }

    func test_preloadedPins_exist() {
        let app = XCUIApplication()
        app.launchArguments.append("UI_TEST_MODE")
        app.launch()

        let pins = app.otherElements.matching(identifier: "map_pin")

        XCTAssertEqual(pins.count, 3)
    }

    func test_mapPerformance() {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
