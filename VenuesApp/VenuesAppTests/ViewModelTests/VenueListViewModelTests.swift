//
//  VenueListViewModelTests.swift
//  VenuesAppTests
//
//

import XCTest
@testable import VenuesApp

final class VenueListViewModelTests: XCTestCase {

    var viewModel: VenueListViewModel!
    var mockUseCase: MockUseCase!

    override func setUp() {
        mockUseCase = MockUseCase()
    }

    func test_loadVenues_success() {

            viewModel.loadVenues()

            XCTAssertEqual(viewModel.veneusList.count, 2)
        }
}
