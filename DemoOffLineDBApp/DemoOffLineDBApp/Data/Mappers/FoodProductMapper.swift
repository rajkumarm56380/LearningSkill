//
//  FoodProductMapper.swift
//  DemoOffLineDBApp
//
//

import Foundation

struct FoodProductMapper {

    static func mapDTOToDomain(_ dto: FoodRecipeDTO) -> Recipe {
        Recipe(id: dto.id, name: dto.name, ingredients: dto.ingredients, instructions: dto.instructions, prepTimeMinutes: dto.prepTimeMinutes, cookTimeMinutes: dto.cookTimeMinutes, servings: dto.servings, difficulty: dto.difficulty, cuisine: dto.cuisine, caloriesPerServing: dto.caloriesPerServing, tags: dto.tags, userId: dto.userId, image: dto.image, rating: dto.rating, reviewCount: dto.reviewCount, mealType: dto.mealType)
    }

    static func mapDTOArrayToDomain(_ dtos: [FoodRecipeDTO]) -> [Recipe] {
        dtos.map { mapDTOToDomain($0) }
    }
}
