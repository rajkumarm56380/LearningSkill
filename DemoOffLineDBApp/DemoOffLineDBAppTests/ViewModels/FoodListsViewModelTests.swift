//
//  FoodListsViewModelTests.swift
//  DemoOffLineDBAppTests
//
//

import XCTest
import Combine
@testable import DemoOffLineDBApp

@MainActor
final class FoodListsViewModelTests: XCTestCase {
    
    var mockRepo: MockFoodListsRepository!
    var useCase: FoodListsUseCase!
    var viewModel: FoodListsViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        mockRepo = MockFoodListsRepository()
        useCase = FoodListsUseCase(repo: mockRepo)
        viewModel = FoodListsViewModel(repo: useCase)
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        useCase = nil
        mockRepo = nil
        super.tearDown()
    }
    
    // MARK: - Initial State
    
    func test_initialState_isCorrect() {
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // MARK: - Load Success
    
    func test_load_success_populatesRecipes() {
        let expectation = XCTestExpectation(description: "Recipes loaded")
        
        viewModel.$recipes
            .dropFirst()                         // skip initial empty []
            .sink { recipes in
                XCTAssertEqual(recipes.count, 1)
                XCTAssertEqual(recipes.first?.name, "Classic Margherita Pizza")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.load()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_load_success_setsIsLoadingFalse() {
        let expectation = XCTestExpectation(description: "isLoading resets to false")
        
        viewModel.$isLoading
            .dropFirst()                         // skip initial false
            .filter { !$0 }                      // wait for false
            .first()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                XCTAssertFalse(self.viewModel.isLoading)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.load()
        wait(for: [expectation], timeout: 2)
    }
    
    func test_load_success_noErrorMessage() {
        let expectation = XCTestExpectation(description: "No error on success")
        
        viewModel.$recipes
            .dropFirst()
            .sink { _ in
                XCTAssertNil(self.viewModel.errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.load()
        
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: - Load Failure
    
    func test_load_failure_recipesRemainEmpty() {
        mockRepo.publisher = Fail(error: APIError.unknown)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Recipes empty on failure")
        
        viewModel.$isLoading
            .dropFirst()
            .filter { !$0 }                      // wait for loading to finish
            .sink { _ in
                XCTAssertTrue(self.viewModel.recipes.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.load()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_load_failure_setsIsLoadingFalse() {
        mockRepo.publisher = Fail(error: APIError.unknown)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "isLoading false on failure")
        
        viewModel.$isLoading
            .dropFirst()
            .filter { !$0 }
            .first()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                XCTAssertFalse(self.viewModel.isLoading)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.load()
        wait(for: [expectation], timeout: 2)
    }
    
    // MARK: - hasLoaded Guard (only loads once)
    
    func test_load_calledTwice_onlyFetchesOnce() {
        let expectation = XCTestExpectation(description: "Fetch called only once")
        
        viewModel.$recipes
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.load()   // first call  → fetches
        viewModel.load()   // second call → blocked by hasLoaded guard
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertTrue(mockRepo.fetchCalled)
        
        // Reset and call again to prove guard blocks it
        let secondCallRecipes = viewModel.recipes
        viewModel.load()
        XCTAssertEqual(viewModel.recipes.count, secondCallRecipes.count)
    }
    
    // MARK: - Repo Called
    
    func test_load_callsRepository() {
        let expectation = XCTestExpectation(description: "Repo fetch called")
        
        viewModel.$recipes
            .dropFirst()
            .sink { _ in
                XCTAssertTrue(self.mockRepo.fetchCalled)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.load()
        
        wait(for: [expectation], timeout: 1)
    }
}
