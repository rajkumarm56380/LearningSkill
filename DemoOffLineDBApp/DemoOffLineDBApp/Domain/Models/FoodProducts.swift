//
//  FoodProducts.swift
//  DemoOffLineDBApp
//
//

import Foundation

// MARK: - FoodProducts
struct FoodProducts: Codable {
    let recipes: [Recipe]
    let total, skip, limit: Int
}

// MARK: - Recipe
struct Recipe: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let ingredients, instructions: [String]
    let prepTimeMinutes, cookTimeMinutes, servings: Int
    let difficulty: String
    let cuisine: String
    let caloriesPerServing: Int
    let tags: [String]
    let userId: Int
    let image: String
    let rating: Double
    let reviewCount: Int
    let mealType: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, ingredients, instructions, prepTimeMinutes, cookTimeMinutes, servings, difficulty, cuisine, caloriesPerServing, tags
        case userId = "userId"
        case image, rating, reviewCount, mealType
    }
}
