//
//  AuthRepository.swift
//  LocationApp
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

        storage.saveUser(user)

        return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func login(email: String, password: String) -> AnyPublisher<User?, Error> {

        let users = storage.fetchUsers(email: email).first
        if !((users?.email.isEmpty) != nil) {
            storage.saveUser(User(id: UUID(), name: "NA", email: email, password: password, isLoggedIn: true))
        }
        let user = storage.fetchUsers(email: email).first {
            $0.email == email && $0.password == password
        }
        return Just(user)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
