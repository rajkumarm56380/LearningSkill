//
//  MockFoodRecipeLocalDataSource.swift
//  DemoOffLineDBAppTests
//
//

import Combine
import Foundation

final class MockFoodRecipeLocalDataSource: FoodRecipeLocalDataSourceProtocol {

    var storedRecipes: [Recipe] = []
    var saveCalled = false

    func fetch() -> [Recipe] {
        return storedRecipes
    }

    func save(_ dtos: [FoodRecipeDTO]) {
        saveCalled = true
        storedRecipes = FoodProductMapper.mapDTOArrayToDomain(dtos)
    }
}

