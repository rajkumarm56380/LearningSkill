//
//  AuthRepositoryImpl.swift
//  DemoOffLineDBApp
//
//

import Combine
import Foundation

final class AuthRepository: AuthRepositoryProtocol {    

    private let remote: AuthServiceProtocol
    private let local: LocalAuthDataSource
    private let network: NetworkMonitor
    private var cancellables = Set<AnyCancellable>()

    init(remote: AuthServiceProtocol,
         local: LocalAuthDataSource,
         network: NetworkMonitor) {
        self.remote = remote
        self.local = local
        self.network = network
    }

    // LOGIN
    func login(email: String, password: String) async throws -> User {

        if network.isConnected {
            let user = try await remote.login(email: email, password: password)
            local.saveUser(user)
            return user
        } else {
            // OFFLINE LOGIN
            guard let localUser = local.fetchLoggedInUser() else {
                throw AuthError.unknown("No offline session found")
            }

            return User(
                id: UUID(uuidString: localUser.id) ?? UUID(),
                name: localUser.name,
                email: localUser.email,
                password: "",
                isLoggedIn: true)
        }
    }

    func signup(user: User) async throws -> User {
        if network.isConnected {
           let user = try await remote.signup(user: user)
            return user
        } else {
            // OFFLINE LOGIN
            guard let localUser = local.fetchLoggedInUser() else {
                throw AuthError.unknown("No offline session found")
            }
            let user = User(
                id: UUID(uuidString: localUser.id) ?? UUID(),
                name: localUser.name,
                email: localUser.email,
                password: "",
                isLoggedIn: true)

            return user
        }
    }

    // AUTO LOGIN (APP START)
    func getCurrentUser() -> User? {
        if let localUser = local.fetchLoggedInUser() {
            return User(
                id: UUID(uuidString: localUser.id) ?? UUID(),
                name: localUser.name,
                email: localUser.email,
                password: "",
                isLoggedIn: true
            )
        }

        return nil
    }

    // LOGOUT
    func logout() async throws {
        try await remote.logout()
        local.logout()
    }
}
