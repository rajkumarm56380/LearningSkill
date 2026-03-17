//
//  GetLocationDetailsUseCaseTests.swift
//  LocationAppTests
//
//

import XCTest
import Combine
import CoreLocation
@testable import LocationApp

final class GetLocationDetailsUseCaseTests: XCTestCase {

    var useCase: GetLocationDetailsUseCase!
    var mockRepository: MockLocationRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockLocationRepository()
        useCase = GetLocationDetailsUseCase(repository: mockRepository)
        cancellables = []
    }

    override func tearDown() {
        useCase = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }

    // MARK: - 1. Returns LocationModel
    func test_execute_returnsLocationModel() {

        let expectation = XCTestExpectation(description: "Returns LocationModel")

        let coordinate = CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946)

        useCase.execute(coordinate: coordinate)
            .sink { location in
                XCTAssertEqual(location.coordinate.latitude, coordinate.latitude)
                XCTAssertEqual(location.coordinate.longitude, coordinate.longitude)
                XCTAssertEqual(location.name, "Mock")
                XCTAssertEqual(location.address, "Mock Address")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - 2. Maps Address Correctly
    func test_execute_mapsAddressCorrectly() {

        let expectation = XCTestExpectation(description: "Maps Address")

        mockRepository.mockLocation.address = "Test Address"

        useCase.execute(coordinate: CLLocationCoordinate2D(latitude: 1, longitude: 1))
            .sink { location in
                XCTAssertEqual(location.address, "Test Address")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - 3. Handles Empty Address
    func test_execute_handlesEmptyAddress() {

        let expectation = XCTestExpectation(description: "Handles Empty Address")

        mockRepository.mockLocation.address = ""

        useCase.execute(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
            .sink { location in
                XCTAssertEqual(location.address, "")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - 4. Multiple Calls Return Correct Values
    func test_execute_multipleCalls() {

        let expectation = XCTestExpectation(description: "Multiple Calls")
        expectation.expectedFulfillmentCount = 2

        mockRepository.mockLocation.address = "Address 1"

        useCase.execute(coordinate: CLLocationCoordinate2D(latitude: 1, longitude: 1))
            .sink { location in
                XCTAssertEqual(location.address, "Address 1")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        mockRepository.mockLocation.address = "Address 2"

        useCase.execute(coordinate: CLLocationCoordinate2D(latitude: 2, longitude: 2))
            .sink { location in
                XCTAssertEqual(location.address, "Address 2")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    // MARK: - 5. Coordinate Mapping Accuracy
    func test_execute_coordinateMapping() {

        let expectation = XCTestExpectation(description: "Coordinate Mapping")

        let coordinate = CLLocationCoordinate2D(latitude: 55.5, longitude: 66.6)

        useCase.execute(coordinate: coordinate)
            .sink { location in
                XCTAssertEqual(location.coordinate.latitude, 55.5, accuracy: 0.0001)
                XCTAssertEqual(location.coordinate.longitude, 66.6, accuracy: 0.0001)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
