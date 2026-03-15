//
//  AuthRepository.swift
//  LocationApp
//
//  Created by Apple on 15/03/26.
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

        let users = storage.fetchUsers()

        let user = users.first {
            $0.email == email && $0.password == password
        }

        return Just(user)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
