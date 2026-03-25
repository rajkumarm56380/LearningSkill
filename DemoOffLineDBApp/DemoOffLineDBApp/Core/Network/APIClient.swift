//
//  APIClient.swift
//  DemoOffLineDBApp
//
//

import Combine
import Foundation

protocol APIClientProtocol {
    func fetchFoodRecipes() -> AnyPublisher<[FoodRecipeDTO], APIError>
    func request<T: Decodable>(_ url: URL) -> AnyPublisher<T, APIError>
}

final class APIClient: APIClientProtocol {
    func fetchFoodRecipes() -> AnyPublisher<[FoodRecipeDTO], APIError> {
        guard let url = URL(string: "https://dummyjson.com/recipes") else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)

        //  Handle HTTP response
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }

                guard (200...299).contains(response.statusCode) else {
                    throw APIError.httpError(response.statusCode)
                }

                return output.data
            }

        //  Decode safely
            .decode(type: FoodProductResponse.self, decoder: JSONDecoder())

        //  Map to your data
            .map { $0.recipes }

        //  Convert all errors into APIError
            .mapError { error -> APIError in

                if let apiError = error as? APIError {
                    return apiError
                }

                if error is DecodingError {
                    return .decodingError
                }

                if let urlError = error as? URLError {
                    return .networkError(urlError.localizedDescription)
                }

                return .unknown
            }

            .eraseToAnyPublisher()
    }

    func request<T: Decodable>(_ url: URL) -> AnyPublisher<T, APIError> {
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { output in
                    guard let response = output.response as? HTTPURLResponse,
                          (200...299).contains(response.statusCode) else {
                        throw APIError.httpError((output.response as? HTTPURLResponse)?.statusCode ?? 0)
                    }
                    return output.data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { error in
                    if let apiError = error as? APIError { return apiError }
                    if error is DecodingError { return .decodingError }
                    return .networkError(error.localizedDescription)
                }
                .eraseToAnyPublisher()
        }
}
