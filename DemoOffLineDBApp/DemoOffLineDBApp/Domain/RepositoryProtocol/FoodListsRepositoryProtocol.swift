//
//  FoodListsRepositoryProtocol.swift
//  DemoOffLineDBApp
//
//

import Combine

protocol FoodListsRepositoryProtocol {
    func fetch() -> AnyPublisher<[Recipe], APIError>
}
