//
//  SignupUseCase.swift
//  DemoCombine
//
//  Created by Apple on 02/03/26.
//

import Combine

final class SignupUseCase {

    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute(
        name: String,
        email: String,
        password: String
    ) -> AnyPublisher<User, Error> {

        // Business validation logic can live here
        guard !name.isEmpty,
              !email.isEmpty,
              !password.isEmpty else {

            return Fail(error: ValidationError.invalidInput)
                .eraseToAnyPublisher()
        }

        return repository.signup(
            name: name,
            email: email,
            password: password
        )
    }
}
