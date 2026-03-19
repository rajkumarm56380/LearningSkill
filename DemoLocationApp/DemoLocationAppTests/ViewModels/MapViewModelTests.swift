//
//  MapViewModelTests.swift
//  MapViewModelTests
//
//

import XCTest
import Combine
import MapKit

@testable import DemoLocationApp

@MainActor
final class MapViewModelTests: XCTestCase {

    var viewModel: MapViewModel!
    var mockUseCase: MockGetLocationDetailsUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()

        mockUseCase = MockGetLocationDetailsUseCase(repository: LocationRepository())
        cancellables = []

        viewModel = MapViewModel(
            locationService: LocationService(),
            useCase: mockUseCase
        )
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    // MARK: 1. Map Position Updates
    func test_currentLocation_updatesMapPosition() {

        let coordinate = CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946)

        viewModel.addPin(coordinate)

        let region = viewModel.mapPosition.region

        XCTAssertEqual(region?.center.latitude ?? 0, coordinate.latitude, accuracy: 0.001)
        XCTAssertEqual(region?.center.longitude ?? 0, coordinate.longitude, accuracy: 0.001)
    }

    // MARK: 2. Add Pin Adds Location
    func test_addPin_addsLocation() {

        let coordinate = CLLocationCoordinate2D(latitude: 12, longitude: 77)

        viewModel.addPin(coordinate)

        XCTAssertEqual(viewModel.locations.count, 1)
    }

    // MARK: 3. Add Pin Sets Selected Location
    func test_addPin_setsSelectedLocation() {

        let coordinate = CLLocationCoordinate2D(latitude: 20, longitude: 20)

        viewModel.addPin(coordinate)

        XCTAssertNotNil(viewModel.selectedLocation)
        XCTAssertEqual(viewModel.selectedLocation?.coordinate.latitude, 20)
    }

    // MARK: 4. No Duplicate Pins
    func test_noDuplicatePins() {

        let coordinate = CLLocationCoordinate2D(latitude: 30, longitude: 30)

        viewModel.addPin(coordinate)
        viewModel.addPin(coordinate)

        XCTAssertEqual(viewModel.locations.count, 1)
    }

    // MARK: 5. Select Location
    func test_selectLocation_updatesSelectedLocation() {

        let location = LocationModel(
            coordinate: CLLocationCoordinate2D(latitude: 40, longitude: 40),
            name: "Test",
            address: "Test Address"
        )

        viewModel.selectLocation(location)

        XCTAssertEqual(viewModel.selectedLocation?.name, "Test")
    }

    // MARK: 6. Clear Selection
    func test_clearSelection_resetsSelectedLocation() {

        let location = LocationModel(
            coordinate: CLLocationCoordinate2D(latitude: 50, longitude: 50),
            name: "Test",
            address: "Test Address"
        )

        viewModel.selectLocation(location)
        viewModel.clearSelection()

        XCTAssertNil(viewModel.selectedLocation)
    }

    // MARK: 7. Multiple Pins
    func test_multiplePins_addedCorrectly() {

        let coords = [
            CLLocationCoordinate2D(latitude: 1, longitude: 1),
            CLLocationCoordinate2D(latitude: 2, longitude: 2),
            CLLocationCoordinate2D(latitude: 3, longitude: 3)
        ]

        coords.forEach { viewModel.addPin($0) }

        XCTAssertEqual(viewModel.locations.count, 3)
    }

    // MARK: 8. Publisher Trigger
    func test_locationPublisher_triggersPinAddition() {

        let expectation = XCTestExpectation(description: "Location added")

        viewModel.$locations
            .dropFirst()
            .sink { locations in
                if locations.count == 1 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        let coordinate = CLLocationCoordinate2D(latitude: 99, longitude: 99)
        viewModel.addPin(coordinate)

        wait(for: [expectation], timeout: 2)
    }

    func test_addPin_shouldAppendLocation() {

        let coordinate = CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946)

        viewModel.addPin(coordinate)

        XCTAssertEqual(viewModel.locations.count, 1)
        XCTAssertEqual(viewModel.selectedLocation?.coordinate.latitude, coordinate.latitude)
    }

    func test_addPin_shouldNotAddDuplicate() {

        let coord = CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946)

        viewModel.addPin(coord)
        viewModel.addPin(coord)

        XCTAssertEqual(viewModel.locations.count, 1)
    }

    func test_address_shouldUpdate_afterAPIResponse() {

        let coord = CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946)

        viewModel.addPin(coord)

        let expectation = XCTestExpectation(description: "Address updated")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotEqual(self.viewModel.locations.first?.address, "Loading...")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }
}
