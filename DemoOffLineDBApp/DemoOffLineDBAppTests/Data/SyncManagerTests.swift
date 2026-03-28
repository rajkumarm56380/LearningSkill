//
//  SyncManagerTests.swift
//  DemoOffLineDBAppTests
//
//

import XCTest
import Combine
@testable import DemoOffLineDBApp

final class SyncManagerTests: XCTestCase {

    var cancellables: Set<AnyCancellable>!
    var network: MockNetworkMonitor!
    var api: MockAPIClient!
    var local: MockFoodRecipeLocalDataSource!
    var sut: SyncManager!

    override func setUp() {
        super.setUp()
        cancellables = []
        network = MockNetworkMonitor()
        api = MockAPIClient()
        local = MockFoodRecipeLocalDataSource()
        sut = SyncManager(network: network, api: api, local: local)
    }

    func test_fetchProducts_offline_returnsLocalData() {
        // GIVEN
        network.isConnected = false
        local.storedRecipes = [
            Recipe( id: 1, name: "Classic Margherita Pizza",
                    ingredients: [], instructions: [],
                    prepTimeMinutes: 25, cookTimeMinutes: 40,
                    servings: 1, difficulty: "Easy", cuisine: "Italian",
                    caloriesPerServing: 300, tags: [], userId: 166,
                    image: "", rating: 4.6, reviewCount: 98, mealType: [])
        ]

        let expectation = XCTestExpectation(description: "Offline fetch")

        // WHEN
        sut.fetchProducts()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { recipes in

                // THEN
                XCTAssertEqual(recipes.count, 1)
                XCTAssertEqual(recipes.first?.name, "Classic Margherita Pizza")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func test_fetchProducts_online_success_savesToLocal() {
        // GIVEN
        network.isConnected = true
        api.shouldFail = false
        api.stubbedDTOs = [
            FoodRecipeDTO(id: 1, name: "Vegetarian Stir-Fry", ingredients: [
                "Pizza dough",
                "Tomato sauce",
                "Fresh mozzarella cheese",
                "Fresh basil leaves",
                "Olive oil",
                "Salt and pepper to taste"
            ], instructions: [
                "Preheat the oven to 475°F (245°C).",
                "Roll out the pizza dough and spread tomato sauce evenly.",
                "Top with slices of fresh mozzarella and fresh basil leaves.",
                "Drizzle with olive oil and season with salt and pepper.",
                "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
                "Slice and serve hot."
            ], prepTimeMinutes: 25, cookTimeMinutes: 40, servings: 1, difficulty: "Easy", cuisine: "Italian", caloriesPerServing: 300, tags: [
                "Pizza",
                "Italian"
            ], userId: 166, image: "https://cdn.dummyjson.com/recipe-images/1.webp", rating: 4.6, reviewCount: 98, mealType: [
                "Dinner"
            ])
        ]

        let expectation = XCTestExpectation(description: "Online fetch success")

        // WHEN
        sut.fetchProducts()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { recipes in

                // THEN
                XCTAssertEqual(recipes.first?.name, "Vegetarian Stir-Fry")
                XCTAssertTrue(self.local.saveCalled)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func test_fetchProducts_online_failure_fallbackToLocal() {
        // GIVEN
        network.isConnected = true
        api.shouldFail = true

        local.storedRecipes = [
            Recipe(id: 1, name: "Classic Margherita Pizza", ingredients: [
                "Pizza dough",
                "Tomato sauce",
                "Fresh mozzarella cheese",
                "Fresh basil leaves",
                "Olive oil",
                "Salt and pepper to taste"
            ], instructions: [
                "Preheat the oven to 475°F (245°C).",
                "Roll out the pizza dough and spread tomato sauce evenly.",
                "Top with slices of fresh mozzarella and fresh basil leaves.",
                "Drizzle with olive oil and season with salt and pepper.",
                "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
                "Slice and serve hot."
            ], prepTimeMinutes: 25, cookTimeMinutes: 40, servings: 1, difficulty: "Easy", cuisine: "Italian", caloriesPerServing: 300, tags: [
                "Pizza",
                "Italian"
            ], userId: 166, image: "https://cdn.dummyjson.com/recipe-images/1.webp", rating: 4.6, reviewCount: 98, mealType: [
                "Dinner"
            ])
        ]

        let expectation = XCTestExpectation(description: "Fallback to local")

        // WHEN
        sut.fetchProducts()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { recipes in
                // THEN
                XCTAssertNotEqual(recipes.first?.name, "Pasta")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func test_fetchProducts_online_failure_noLocal_returnsError() {
        // GIVEN
        network.isConnected = true
        api.shouldFail = true
        local.storedRecipes = []

        let expectation = XCTestExpectation(description: "Return error")

        // WHEN
        sut.fetchProducts()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }
    
    override func tearDown() {
        cancellables = nil
        network = nil
        api = nil
        local = nil
        sut = nil
        super.tearDown()
    }
}
