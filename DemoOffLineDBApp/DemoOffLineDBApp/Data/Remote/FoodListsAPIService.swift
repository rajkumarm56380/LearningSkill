//
//  FoodListsAPIService.swift
//  DemoOffLineDBApp
//
//

import Combine
import Foundation

final class FoodListsAPIService: APIClientProtocol {

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
