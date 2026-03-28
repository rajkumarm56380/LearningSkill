//
//  MockFoodListsRepository.swift
//  DemoOffLineDBAppTests
//
//

import Combine

final class MockFoodListsRepository: FoodListsRepositoryProtocol {

    var fetchCalled = false

    var publisher: AnyPublisher<[Recipe], APIError> = Just([
        Recipe(id: 1, name: "Classic Margherita Pizza",
               ingredients: [], instructions: [],
               prepTimeMinutes: 25, cookTimeMinutes: 40,
               servings: 1, difficulty: "Easy", cuisine: "Italian",
               caloriesPerServing: 300, tags: [], userId: 1,
               image: "", rating: 4.6, reviewCount: 98, mealType: [])
    ])
        .setFailureType(to: APIError.self)
        .eraseToAnyPublisher()

    func fetch() -> AnyPublisher<[Recipe], APIError> {
        fetchCalled = true
        return publisher
    }
}
