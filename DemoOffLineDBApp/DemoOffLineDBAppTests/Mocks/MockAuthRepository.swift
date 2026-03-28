//
//  MockAuthRepository.swift
//  DemoOffLineDBAppTests
//
//

import Foundation

final class MockAuthRepository: AuthRepositoryProtocol {

    // MARK: - Control Flags
    var shouldFail = false
    var isLoggedIn = false

    // MARK: - Stubbed Data
    var mockUser: User = User(
        id: UUID(),
        name: "Mock User",
        email: "mock@test.com",
        password: "",
        isLoggedIn: true
    )

    var loginResult: Result<User, Error> = .success(
        User(id: UUID(), name: "Test User", email: "test@test.com", password: "password", isLoggedIn: true)
    )
    
    var signupResult: Result<User, Error> = .success(
        User(id: UUID(), name: "New User", email: "new@mail.com", password: "123456", isLoggedIn: true)
    )

    // MARK: - Tracking Calls (for assertions)
    private(set) var loginCalled = false
    private(set) var signupCalled = false
    private(set) var logoutCalled = false
    private(set) var getCurrentUserCalled = false


    // MARK: - LOGIN
    func login(email: String, password: String) async throws -> User {
        loginCalled = true

        if shouldFail {
            throw AuthError.invalidCredential
        }

        isLoggedIn = true

        return User(
            id: UUID(),
            name: "Test User",
            email: email,
            password: "123456",
            isLoggedIn: true
        )
    }

    // MARK: - SIGNUP
    func signup(user: User) async throws -> User {
        signupCalled = true

        if shouldFail {
            throw AuthError.emailAlreadyInUse
        }

        isLoggedIn = true
        return user
    }

    // MARK: - GET CURRENT USER
    func getCurrentUser() -> User? {
        getCurrentUserCalled = true

        return isLoggedIn ? mockUser : nil
    }

    // MARK: - LOGOUT
    func logout() async throws {
        logoutCalled = true

        if shouldFail {
            throw AuthError.unknown("Logout failed")
        }

        isLoggedIn = false
        
    }
}
