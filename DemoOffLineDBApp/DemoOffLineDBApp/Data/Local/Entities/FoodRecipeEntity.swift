//
//  FoodRecipeEntity.swift
//  DemoOffLineDBApp
//

import SwiftData

@Model
final class FoodRecipeEntity {

    @Attribute(.unique) var id: Int
    var name: String
    var ingredients: [String]
    var instructions: [String]
    var prepTimeMinutes: Int
    var cookTimeMinutes: Int
    var servings: Int
    var difficulty: String
    var cuisine: String
    var caloriesPerServing: Int
    var tags: [String]
    var userId: Int
    var image: String
    var rating: Double
    var reviewCount: Int
    var mealType: [String]

    init(id: Int, name: String, ingredients: [String], instructions: [String], prepTimeMinutes: Int, cookTimeMinutes: Int, servings: Int, difficulty: String, cuisine: String, caloriesPerServing: Int, tags: [String], userId: Int, image: String, rating: Double, reviewCount: Int, mealType: [String]) {
        self.id = id
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
        self.prepTimeMinutes = prepTimeMinutes
        self.cookTimeMinutes = cookTimeMinutes
        self.servings = servings
        self.difficulty = difficulty
        self.cuisine = cuisine
        self.caloriesPerServing = caloriesPerServing
        self.tags = tags
        self.userId = userId
        self.image = image
        self.rating = rating
        self.reviewCount = reviewCount
        self.mealType = mealType
    }
}
