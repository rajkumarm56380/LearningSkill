//
//  LocationRepositoryTests.swift
//  LocationAppTests
//
//

import XCTest
import Combine
import CoreLocation
@testable import LocationApp

final class LocationRepositoryTests: XCTestCase {

    var repository: LocationRepository!
    var mockGeocoder: MockGeocoderService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockGeocoder = MockGeocoderService()
        repository = LocationRepository(geocoder: mockGeocoder)
        cancellables = []
    }

    override func tearDown() {
        repository = nil
        mockGeocoder = nil
        cancellables = nil
        super.tearDown()
    }

    // MARK: - 1. Verify Geocoder is Called
    func test_getAddress_callsGeocoder() {

        let coordinate = CLLocationCoordinate2D(latitude: 10, longitude: 10)

        let expectation = XCTestExpectation(description: "Geocoder called")

        repository.getAddress(for: coordinate)
            .sink { _ in
                XCTAssertTrue(self.mockGeocoder.isCalled)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - 2. Verify Correct Value Returned
    func test_getAddress_returnsCorrectValue() {

        let expectedAddress = "Bangalore"
        mockGeocoder.mockLocation.address = expectedAddress

        let coordinate = CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946)

        let expectation = XCTestExpectation(description: "Returns correct address")

        repository.getAddress(for: coordinate)
            .sink { locationDetails in
                XCTAssertEqual(locationDetails.address, expectedAddress)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
