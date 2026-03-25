//
//  ProductRepositoryProtocol.swift
//  DemoOffLineDBApp
//
//

import Combine

protocol ProductRepositoryProtocol {
    func fetch() -> AnyPublisher<[Product], Error>
}
