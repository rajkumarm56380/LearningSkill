//
//  SessionManager.swift
//  DemoOffLineDBApp
//
//

import FirebaseAuth
import Combine

@MainActor
final class SessionManager: ObservableObject {

    @Published private(set) var user: User?
    private let repo: AuthRepositoryProtocol
    private let service: AuthServiceProtocol

    var isLoggedIn: Bool { user != nil }

    init(repo: AuthRepositoryProtocol,
         service: AuthServiceProtocol) {
        self.repo = repo
        self.service = service
        observeAuth()
    }

    private func observeAuth() {
        Task {
            for await authUser in service.observeAuthState() {
                self.user = authUser
            }
        }
    }

    func setUser(_ user: User) {
        self.user = user
    }

    func clearUser() {
        self.user = nil
    }

    func getUser() -> User? {
        return user
    }
}
