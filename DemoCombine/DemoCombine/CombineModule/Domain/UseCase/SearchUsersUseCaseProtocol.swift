//
//  SearchUsersUseCaseProtocol.swift
//  DemoCombine
//
//  Created by user on 02/03/26.
//
import Combine
import Foundation

protocol SearchUsersUseCaseProtocol {
    func execute(query: String) -> AnyPublisher<[User], Error>
}

final class SearchUsersUseCase: SearchUsersUseCaseProtocol {

    private let repository: SearchRepositoryProtocol

    init(repository: SearchRepositoryProtocol) {
        self.repository = repository
    }

    func execute(query: String) -> AnyPublisher<[User], Error> {
        repository.searchUsers(query: query)
    }
}
