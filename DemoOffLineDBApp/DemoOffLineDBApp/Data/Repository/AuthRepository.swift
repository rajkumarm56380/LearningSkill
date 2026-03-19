//
//  AuthRepository.swift
//  DemoOffLineDBApp
//
//

import Combine
import Foundation

final class AuthRepository: AuthRepositoryProtocol {

    private let storage: UserStorageProtocol

    init(storage: UserStorageProtocol) {
        self.storage = storage
    }

    func signup(user: User) -> AnyPublisher<Bool, Error> {
        let users = storage.fetchUsers()

        //  Check if user already exists (case-insensitive email)
        if users.contains(where: {
            $0.email.lowercased() == user.email.lowercased()
        }) {
            return Fail(error: AuthError.userAlreadyExists)
                .eraseToAnyPublisher()
        }

        // Save user
        storage.saveUser(user)

        return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func login(email: String, password: String) -> AnyPublisher<User?, Error> {

        guard storage.isUserExist(email: email) else {
            return Fail(error: AuthError.userNotFound)
                .eraseToAnyPublisher()
        }

        //  Find matching user
        guard let user = storage.fetchUsers().first(where: {
            $0.email.lowercased() == email.lowercased() &&
            $0.password == password
        }) else {
            return Fail(error: AuthError.invalidCredentials)
                .eraseToAnyPublisher()
        }
        // Return valid user
        return Just(user)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

