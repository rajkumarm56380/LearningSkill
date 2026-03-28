//
//  MockAuthService.swift
//  DemoOffLineDBAppTests
//

import Foundation

final class MockAuthService: AuthServiceProtocol {

    var shouldFail = false
    var currentUser: User? = nil

    // Stream continuation
    private var continuation: AsyncStream<User?>.Continuation?

    func login(email: String, password: String) async throws -> User {
        if shouldFail { throw AuthError.invalidCredential }
        let user = User(id: UUID(),name: "Test",email: email,password: "",
            isLoggedIn: true)
        currentUser = user
        continuation?.yield(user)
        return user
    }

    func signup(user: User) async throws -> User {
        if shouldFail { throw AuthError.emailAlreadyInUse }
        currentUser = user
        continuation?.yield(user)
        return user
    }

    func logout() async throws {
        if shouldFail { throw AuthError.unknown("Logout failed") }
        currentUser = nil
        continuation?.yield(nil)
    }

    func observeAuthState() -> AsyncStream<User?> {
        AsyncStream { continuation in
            self.continuation = continuation
            continuation.yield(currentUser) // initial value
        }
    }
}
