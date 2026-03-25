//
//  CartAPIService.swift
//  DemoOffLineDBApp
//
//

import Combine
import Foundation

final class CartAPIService {
    func fetch() -> AnyPublisher<[ProductDTO], Error> {
        let url = URL(string: "https://dummyjson.com/carts")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ProductResponse.self, decoder: JSONDecoder())
            .map { $0.products }
            .eraseToAnyPublisher()
    }
}
