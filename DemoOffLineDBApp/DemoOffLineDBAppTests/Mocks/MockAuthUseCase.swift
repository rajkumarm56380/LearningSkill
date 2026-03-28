//
//  MockAuthUseCase.swift
//  DemoOffLineDBAppTests
//
//

import Foundation

final class MockAuthUseCase: AuthUseCaseProtocol {

    // MARK: - Control Flags
    var shouldFailLogin = false
    var shouldFailSignup = false
    var shouldFailLogout = false

    // MARK: - Call Tracking
    private(set) var loginCalled = false
    private(set) var signupCalled = false
    private(set) var logoutCalled = false

    // MARK: - Stubbed Results
    var stubbedUser = User(
        id: UUID(),
        name: "Test User",
        email: "test@test.com",
        password: "",
        isLoggedIn: true
    )

    func executeLogin(email: String, password: String) async throws -> User {
        loginCalled = true
        if shouldFailLogin { throw AuthError.invalidCredential }
        return stubbedUser
    }

    func executeSignup(user: User) async throws -> User {
        signupCalled = true
        if shouldFailSignup { throw AuthError.emailAlreadyInUse }
        return user
    }

    func executeLogout() async throws {
        logoutCalled = true
        if shouldFailLogout { throw AuthError.unknown("Logout failed") }
    }
}
