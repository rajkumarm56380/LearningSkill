//
//  FoodRecipeLocalDataSourceProtocol.swift
//  DemoOffLineDBApp
//
//

protocol FoodRecipeLocalDataSourceProtocol {
    func fetch() -> [Recipe]
    func save(_ dtos: [FoodRecipeDTO])
}
