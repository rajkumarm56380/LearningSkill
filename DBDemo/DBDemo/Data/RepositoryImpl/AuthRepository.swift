//
//  AuthRepository.swift
//  DBDemo
//
//
//

import Combine
import Foundation

final class AuthRepository: AuthRepositoryProtocol {
    private let stack: SwiftDataStack
    init(stack: SwiftDataStack) { self.stack = stack }

    func login(email: String, password: String) throws {
        let users = stack.fetch(UserEntity.self)
        guard users.contains(where: { $0.email == email && $0.password == password }) else {
            throw NSError(domain: "Login", code: 1)
        }
    }

    func signup(email: String, password: String) throws {
        let user = UserEntity(email: email, password: password)
        stack.insert(user)
    }
}
