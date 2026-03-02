//
//  FetchUsersUseCase.swift
//  DemoCombine
//
//  Created by Apple on 02/03/26.
//

import Combine

final class FetchUsersUseCase {

    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[User], Error> {
        repository.fetchUsers()
    }
}
