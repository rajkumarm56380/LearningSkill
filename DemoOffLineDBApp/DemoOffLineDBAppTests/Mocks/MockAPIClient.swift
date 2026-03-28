//
//  MockAPIClient.swift
//  DemoOffLineDBAppTests
//
//  Created by Apple on 28/03/26.
//

import Combine
import Foundation

final class MockAPIClient: APIClientProtocol {
    var shouldFail = false

    // Store any Decodable stub, keyed by URL string
    var stubbedDTOs: [FoodRecipeDTO] = [
            FoodRecipeDTO(
                id: 1,
                name: "Pasta",
                ingredients: [],
                instructions: [],
                prepTimeMinutes: 10,
                cookTimeMinutes: 20,
                servings: 2,
                difficulty: "Easy",
                cuisine: "Italian",
                caloriesPerServing: 400,
                tags: [],
                userId: 1,
                image: "",
                rating: 4.5,
                reviewCount: 10,
                mealType: []
            )
        ]

    func request<T: Decodable>(_ url: URL) -> AnyPublisher<T, APIError> {
        if shouldFail {
            return Fail(error: APIError.unknown)
                .eraseToAnyPublisher()
        }

        guard let result = stubbedDTOs as? T else {
            return Fail(error: APIError.decodingError)
                .eraseToAnyPublisher()
        }

        return Just(result)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
