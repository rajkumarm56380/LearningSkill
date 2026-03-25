//
//  ProductRepositoryProtocol.swift
//  DemoOffLineDBApp
//
//

import Combine

protocol ProductRepositoryProtocol {
    func fetch() -> AnyPublisher<[Recipe], APIError>
}
