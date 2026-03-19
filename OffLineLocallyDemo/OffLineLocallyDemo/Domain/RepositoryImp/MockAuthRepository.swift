//
//  MockAuthRepository.swift
//  LocationApp
//
//

import Combine
import Foundation
final class MockAuthRepository: AuthRepositoryProtocol {

    func signup(user: User) -> AnyPublisher<Bool, Error> {

        return Just(true)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func login(email: String, password: String) -> AnyPublisher<User?, Error> {

        let mockUser = User(
            id: UUID(),
            name: "Raj",
            email: "raj@test.com",
            password: "1234",
            isLoggedIn: true
        )

        if email == "raj@test.com" && password == "1234" {
            return Just(mockUser)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        return Just(nil)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
