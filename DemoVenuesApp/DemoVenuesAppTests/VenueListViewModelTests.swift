//
//  DemoVenuesAppTests.swift
//  DemoVenuesAppTests
//
// 
//
import Combine
import XCTest
@testable import DemoVenuesApp

final class VenueListViewModelTests: XCTestCase {

    var viewModel: VenueListViewModel!
    var mockUseCase: MockVenueUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockUseCase = MockVenueUseCase()
        viewModel = VenueListViewModel(useCase: mockUseCase)
        cancellables = []
    }

    func test_fetch_from_api() {

        let expectation = expectation(description: "API fetch")

        mockUseCase.scenario = .apiSuccess

        viewModel.$venuesList
            .dropFirst()
            .sink { venues in
                XCTAssertEqual(venues.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadVenues()

        waitForExpectations(timeout: 2)
    }

    func test_cache_saved_after_api_success() {

        let expectation = expectation(description: "Cache after API")

        mockUseCase.scenario = .apiSuccess

        viewModel.$venuesList
            .dropFirst()
            .sink { venues in
                XCTAssertFalse(venues.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadVenues()

        waitForExpectations(timeout: 2)
    }

    func test_return_cached_when_network_fails() {

        let expectation = expectation(description: "Cached fallback")

        mockUseCase.scenario = .cachedData

        viewModel.$venuesList
            .dropFirst()
            .sink { venues in
                XCTAssertEqual(venues.first?.title, "Cached Cafe")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadVenues()

        waitForExpectations(timeout: 2)
    }

    func test_return_mock_when_no_cache() {

        let expectation = expectation(description: "Mock fallback")

        mockUseCase.scenario = .emptyResponse

        viewModel.$venuesList
            .dropFirst()
            .sink { venues in
                XCTAssertFalse(venues.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadVenues()

        waitForExpectations(timeout: 2)
    }

    func test_return_cached_when_offline() {

        let expectation = expectation(description: "Offline fallback")

        mockUseCase.scenario = .offline

        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadVenues()

        waitForExpectations(timeout: 2)
    }

    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
    }
}

