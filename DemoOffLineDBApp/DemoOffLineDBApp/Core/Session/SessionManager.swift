//
//  SessionManager.swift
//  DemoOffLineDBApp
//
//

import FirebaseAuth
import Combine


final class SessionManager: ObservableObject {

    @Published var user: User?

    var isLoggedIn: Bool {
        user != nil
    }

    private let repo: AuthRepositoryProtocol
    private let service: AuthServiceProtocol

    init(repo: AuthRepositoryProtocol,
         service: AuthServiceProtocol) {
        self.repo = repo
        self.service = service
        self.user = repo.getCurrentUser() 
        observeAuth()
    }

    private func observeAuth() {
        Task {
            for await user in service.observeAuthState() {
                await MainActor.run {
                    self.user = user
                }
            }
        }
    }

    func login(email: String, password: String) {
        Task {
            do {
                let user = try await repo.login(email: email, password: password)
                await MainActor.run {
                    self.user = user
                }
            } catch {
                print(error)
            }
        }
    }

    func logout() {
        Task {
            try? await repo.logout()
            await MainActor.run {
                self.user = nil
            }
        }
    }
}

/*
final class SessionManager: ObservableObject {

    @Published var state: AuthState = .loading
    @Published var user: User?
    
    var isLoggedIn: Bool {
        user != nil
    }

    private var cancellables = Set<AnyCancellable>()

    init(authService: FirebaseAuthService) {
        observe(authService)
    }

    private func observe(_ authService: FirebaseAuthService) {
        authService.observeAuthState()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                guard let self = self else { return }

                if let user = user {
                    self.state = .authenticated(user)
                    self.user = user
                } else {
                    self.state = .unauthenticated
                }
            }
            .store(in: &cancellables)
    }
}

*/
