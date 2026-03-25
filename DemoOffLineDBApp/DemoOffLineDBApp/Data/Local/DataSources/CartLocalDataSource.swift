//
//  CartLocalDataSource.swift
//  DemoOffLineDBApp
//
//

import Foundation
import SwiftData

final class CartLocalDataSource {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(_ dtos: [FoodRecipeDTO]) {
        try? context.delete(model: FoodRecipeEntity.self)
        dtos.forEach {
            context.insert(FoodRecipeEntity(id: $0.id, name: $0.name, ingredients: $0.ingredients, instructions: $0.instructions, prepTimeMinutes: $0.prepTimeMinutes, cookTimeMinutes: $0.cookTimeMinutes, servings: $0.servings, difficulty: $0.difficulty, cuisine: $0.cuisine, caloriesPerServing: $0.caloriesPerServing, tags: $0.tags, userId: $0.userId, image: $0.image, rating: $0.rating, reviewCount: $0.reviewCount, mealType: $0.mealType))
        }
        try? context.save()
    }

    func fetch() -> [Recipe] {
        let entities = (try? context.fetch(FetchDescriptor<FoodRecipeEntity>())) ?? []
        return entities.map {
            Recipe(id: $0.id, name: $0.name, ingredients: $0.ingredients, instructions: $0.instructions, prepTimeMinutes: $0.prepTimeMinutes, cookTimeMinutes: $0.cookTimeMinutes, servings: $0.servings, difficulty: $0.difficulty, cuisine: $0.cuisine, caloriesPerServing: $0.caloriesPerServing, tags: $0.tags, userId: $0.userId, image: $0.image, rating: $0.rating, reviewCount: $0.reviewCount, mealType: $0.mealType)
        }
    }
}
