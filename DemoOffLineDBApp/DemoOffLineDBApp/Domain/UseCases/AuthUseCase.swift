//
//  AuthUseCase.swift
//  DemoOffLineDBApp
//
 
//

import Foundation

protocol AuthUseCaseProtocol {
    func executeSignup(user: User) async throws -> User
    func executeLogin(email: String, password: String) async throws -> User
    func executeLogout() async throws
}

final class AuthUseCase: AuthUseCaseProtocol {

    private let repo: AuthRepositoryProtocol

    init(repo: AuthRepositoryProtocol) {
        self.repo = repo
    }

    func executeLogin(email: String, password: String) async throws -> User {
        try await repo.login(email: email, password: password)
    }

    func executeSignup(user:User) async throws -> User {
        try await repo.signup(user: user)
    }

    func executeLogout() async throws { 
        try await repo.logout()
    }
}
