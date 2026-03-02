//
//  LoginUseCase.swift
//  DemoCombine
//
//  Created by Apple on 02/03/26.
//

import Combine

final class LoginUseCase {
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute(email: String, password: String)
        -> AnyPublisher<User, Error> {
        repository.login(email: email, password: password)
    }
}
