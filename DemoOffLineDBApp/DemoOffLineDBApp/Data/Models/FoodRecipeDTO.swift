//
//  FoodRecipeDTO.swift
//  DemoOffLineDBApp
//
//

import Foundation

struct FoodProductResponse: Decodable {
    let recipes: [FoodRecipeDTO]
    let total, skip, limit: Int
}

struct FoodRecipeDTO: Decodable {

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

    func toDomain() -> Recipe {
        Recipe(id: id, name: name, ingredients: ingredients, instructions: instructions, prepTimeMinutes: prepTimeMinutes, cookTimeMinutes: cookTimeMinutes, servings: servings, difficulty: difficulty, cuisine: cuisine, caloriesPerServing: caloriesPerServing, tags: tags, userId: userId, image: image, rating: rating, reviewCount: reviewCount, mealType: mealType)
    }
}
