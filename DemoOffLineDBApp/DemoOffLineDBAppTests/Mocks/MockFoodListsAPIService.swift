//
//  MockFoodListsAPIService.swift
//  DemoOffLineDBAppTests
//
//

import Combine
import Foundation

final class MockFoodListsAPIService: APIClientProtocol {

    var shouldFail = false
    var mockData: Any?

    func request<T>(_ url: URL) -> AnyPublisher<T, APIError> where T : Decodable {

        if shouldFail {
            return Fail(error: APIError.networkError("Mock error"))
                .eraseToAnyPublisher()
        }

        if let data = mockData as? T {
            return Just(data)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        }

        return Fail(error: APIError.decodingError)
            .eraseToAnyPublisher()
    }
}
