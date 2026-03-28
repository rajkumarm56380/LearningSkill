//
//  FoodListsUseCase.swift
//  DemoOffLineDBApp
//

import Combine
import Foundation

protocol FoodListsUseCaseProtocol {
    func execute() -> AnyPublisher<[Recipe], APIError>
}

final class FoodListsUseCase: FoodListsUseCaseProtocol {

    private let repo: FoodListsRepositoryProtocol

    init(repo: FoodListsRepositoryProtocol) {
        self.repo = repo
    }

    func execute() -> AnyPublisher<[Recipe], APIError> {
        repo.fetch()
    }
}
