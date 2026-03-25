//
//  APIClient.swift
//  DemoOffLineDBApp
//
//

import Combine
import Foundation

protocol APIClientProtocol {
    func fetchCarts() -> AnyPublisher<[ProductDTO], Error>
}

final class APIClient: APIClientProtocol {
    func fetchCarts() -> AnyPublisher<[ProductDTO], Error> {
        let url = URL(string: "https://dummyjson.com/carts")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ProductResponse.self, decoder: JSONDecoder())
            .map { $0.products }
            .eraseToAnyPublisher()
    }
}
