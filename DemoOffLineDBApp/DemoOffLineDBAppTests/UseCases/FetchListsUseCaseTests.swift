//
//  FetchListsUseCaseTests.swift
//  DemoOffLineDBAppTests
//
//

import Combine
import Foundation
import XCTest
@testable import DemoOffLineDBApp

final class FetchListsUseCaseTests: XCTestCase {

    var mockRepo: MockFoodListsRepository!
    var useCase: FoodListsUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepo = MockFoodListsRepository()
        useCase = FoodListsUseCase(repo: mockRepo)
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        mockRepo = nil
        useCase = nil
        super.tearDown()
    }
    func test_fetch_success() {
        // GIVEN
        let expectation = XCTestExpectation(description: "Fetch Recipes")

        // WHEN
        useCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success")
                }
            }, receiveValue: { recipes in
                // THEN
                XCTAssertEqual(recipes.count, 1)
                XCTAssertTrue(self.mockRepo.fetchCalled)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func test_fetch_failure() {
        // GIVEN
        mockRepo.publisher = Fail(error: APIError.unknown)
            .eraseToAnyPublisher()

        let expectation = XCTestExpectation(description: "Fetch Failure")

        // WHEN
        useCase.execute()
            .sink(receiveCompletion: { completion in
                // THEN
                if case .failure = completion {
                    XCTAssertTrue(true)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
}
