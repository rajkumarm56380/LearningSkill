//
//  FoodRecipeLocalDataSourceTests.swift
//  DemoOffLineDBAppTests
//
//

import XCTest
import SwiftData
@testable import DemoOffLineDBApp

final class MockFoodRecipeLocalDataSourceTests: XCTestCase {

    var mock: MockFoodRecipeLocalDataSource!

    override func setUp() {
        super.setUp()
        mock = MockFoodRecipeLocalDataSource()
    }

    override func tearDown() {
        mock = nil
        super.tearDown()
    }

    func test_save_mapsDTOToDomain() {
        // GIVEN
        let dto = FoodRecipeDTO(id: 1, name: "Classic Margherita Pizza", ingredients: [
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

        // WHEN
        mock.save([dto])

        // THEN
        XCTAssertTrue(mock.saveCalled)
        XCTAssertEqual(mock.storedRecipes.count, 1)
        XCTAssertEqual(mock.storedRecipes.first?.name, "Classic Margherita Pizza")
    }
}
