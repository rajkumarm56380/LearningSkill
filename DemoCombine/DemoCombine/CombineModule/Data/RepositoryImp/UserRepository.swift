//
//  UserRepositoryProtocol.swift
//  DemoCombine
//
//  Created by user on 02/03/26.
//

import Combine
import Foundation

import Combine

final class UserRepository: UserRepositoryProtocol {

    private var users: [User] = []

    func login(email: String, password: String)
        -> AnyPublisher<User, Error> {

        guard let user = users.first(where: { $0.email == email }) else {
            return Fail(error: AuthError.userNotFound)
                .eraseToAnyPublisher()
        }

        return Just(user)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func signup(
        name: String,
        email: String,
        password: String
    ) -> AnyPublisher<User, Error> {

        if users.contains(where: { $0.email == email }) {
            return Fail(error: AuthError.userAlreadyExists)
                .eraseToAnyPublisher()
        }

        let newUser = User(
            id: Int.random(in: 1...100),
            name: name,
            email: email
        )

        users.append(newUser)

        return Just(newUser)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchUsers()
        -> AnyPublisher<[User], Error> {

        Just(users)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
