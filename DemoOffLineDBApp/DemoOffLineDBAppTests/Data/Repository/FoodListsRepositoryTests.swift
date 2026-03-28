//
//  FoodListsRepositoryTests.swift
//  DemoOffLineDBAppTests
//
//

import Combine
import XCTest

final class FoodListsRepositoryTests: XCTestCase {

    var sut: FoodListsRepositoryImpl!
    var sync: SyncManager!
    var cancellables: Set<AnyCancellable>!

    var mockNetwork: MockNetworkMonitor!
    var mockAPI: MockAPIClient!
    var mockLocal: MockFoodRecipeLocalDataSource!

    override func setUp() {
        super.setUp()
        cancellables = []
        mockNetwork = MockNetworkMonitor()
        mockAPI = MockAPIClient()
        mockLocal = MockFoodRecipeLocalDataSource()

        sync = SyncManager(network: mockNetwork, api: mockAPI, local: mockLocal)
        sut = FoodListsRepositoryImpl(sync: sync)
    }

    override func tearDown() {
        cancellables = nil
        sut = nil
        sync = nil
        mockAPI = nil
        mockLocal = nil
        mockNetwork = nil
        super.tearDown()
    }

    // MARK: - Online: API returns data

    func test_fetchProducts_online_returnsRecipesFromAPI() {
        mockNetwork.isConnected = true
        let expectation = XCTestExpectation(description: "Returns recipes from API")

        sync.fetchProducts()                     // ← call the real method name
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("Unexpected failure: \(error)")
                    }
                },
                receiveValue: { recipes in
                    XCTAssertFalse(recipes.isEmpty)
                    XCTAssertEqual(recipes.first?.name, "Pasta")
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }

    // MARK: - Offline: returns local cache

    func test_fetchProducts_offline_returnsLocalCache() {
        mockNetwork.isConnected = false
        mockLocal.storedRecipes = [Recipe(id: 1, name: "Cached Pasta", ingredients: [], instructions: [], prepTimeMinutes: 0, cookTimeMinutes: 0, servings: 0, difficulty: "", cuisine: "", caloriesPerServing: 0, tags: [], userId: 0, image: "", rating: 0.0, reviewCount: 0, mealType: [])] 
        let expectation = XCTestExpectation(description: "Returns cached recipes when offline")

        sync.fetchProducts()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { recipes in
                    XCTAssertEqual(recipes.first?.name, "Cached Pasta")
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }

    // MARK: - Online: API fails, fallback to local cache

    func test_fetchProducts_apiFailure_fallsBackToLocal() {
        mockNetwork.isConnected = true
        mockAPI.shouldFail = true
        mockLocal.storedRecipes = [Recipe(id: 1, name: "Fallback Recipe", ingredients: [], instructions: [], prepTimeMinutes: 0, cookTimeMinutes: 0, servings: 0, difficulty: "", cuisine: "", caloriesPerServing: 0, tags: [], userId: 0, image: "", rating: 0.0, reviewCount: 0, mealType: [])]
        let expectation = XCTestExpectation(description: "Falls back to local on API failure")

        sync.fetchProducts()
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("Should have fallen back to local, got error: \(error)")
                    }
                },
                receiveValue: { recipes in
                    XCTAssertEqual(recipes.first?.name, "Fallback Recipe")
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }

    // MARK: - Online: API fails, no local cache → emits error

    func test_fetchProducts_apiFailure_noLocalCache_emitsError() {
        mockNetwork.isConnected = true
        mockAPI.shouldFail = true
        mockLocal.storedRecipes = []                          // empty cache
        let expectation = XCTestExpectation(description: "Emits error when API and cache both empty")

        sync.fetchProducts()
            .sink(
                receiveCompletion: { completion in
                    if case .failure = completion {
                        expectation.fulfill()                 // ← expected path
                    }
                },
                receiveValue: { _ in
                    XCTFail("Should not emit value")
                }
            )
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }
}

/*
final class FoodListsRepositoryTestsOld: XCTestCase {

    var sut: FoodListsRepositoryImpl!
       var sync: SyncManager!
       var cancellables: Set<AnyCancellable>!

       var mockNetwork: MockNetworkMonitor!
       var mockAPI: MockFoodListsAPIService!
       var mockLocal: MockFoodRecipeLocalDataSource!

       override func setUp() {
           super.setUp()
           cancellables = []
           mockNetwork = MockNetworkMonitor()
           mockAPI = MockFoodListsAPIService()
           mockLocal = MockFoodRecipeLocalDataSource()

           sync = SyncManager(network: mockNetwork, api: mockAPI, local: mockLocal)
           sut = FoodListsRepositoryImpl(sync: sync)
       }

       override func tearDown() {
           cancellables = nil
           sut = nil
           sync = nil
           super.tearDown()
       }

       // MARK: - Fetch success (online)

       func test_fetch_online_returnsRecipesFromAPI() {
           mockNetwork.isConnected = true
           let expectation = XCTestExpectation(description: "Fetch returns recipes from API")

           sut.fetchProducts()
               .sink(
                   receiveCompletion: { completion in
                       if case .failure(let error) = completion {
                           XCTFail("Unexpected failure: \(error)")
                       }
                   },
                   receiveValue: { recipes in
                       XCTAssertFalse(recipes.isEmpty)
                       expectation.fulfill()
                   }
               )
               .store(in: &cancellables)

           wait(for: [expectation], timeout: 10)
       }

       // MARK: - Fetch success (offline, uses local cache)

       func test_fetch_offline_returnsLocalRecipes() {
           mockNetwork.isConnected = false
           mockLocal.storedRecipes =
           [Recipe(id: 1, name: "Cached", ingredients: [], instructions: [], prepTimeMinutes: 0, cookTimeMinutes: 0, servings: 0, difficulty: "", cuisine: "", caloriesPerServing: 0, tags: [], userId: 0, image: "", rating: 0.0, reviewCount: 0, mealType: [])]
           let expectation = XCTestExpectation(description: "Fetch returns cached recipes")

           sut.fetch()
               .sink(
                   receiveCompletion: { _ in },
                   receiveValue: { recipes in
                       XCTAssertFalse(recipes.isEmpty)
                       expectation.fulfill()
                   }
               )
               .store(in: &cancellables)

           wait(for: [expectation], timeout: 2)
       }

       // MARK: - Fetch failure (API fails)

       func test_fetch_apiFailure_emitsError() {
           mockNetwork.isConnected = true
           mockAPI.shouldFail = true
           let expectation = XCTestExpectation(description: "Fetch emits error on API failure")

           sut.fetch()
               .sink(
                   receiveCompletion: { completion in
                       if case .failure = completion {
                           expectation.fulfill()
                       }
                   },
                   receiveValue: { _ in
                       XCTFail("Should not emit value on failure")
                   }
               )
               .store(in: &cancellables)

           wait(for: [expectation], timeout: 2)
       }
}
*/
