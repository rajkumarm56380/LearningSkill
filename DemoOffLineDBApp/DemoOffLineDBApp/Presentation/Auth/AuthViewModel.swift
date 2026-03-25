//
//  AuthViewModel.swift
//  DemoOffLineDBApp
//
//

import Foundation
import Combine

@MainActor
final class AuthViewModel: ObservableObject {

    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var signupSuccess: Bool = false
    @Published var loggedUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    private let router: AppRouter
    private let session: SessionManager
    private let repo: AuthRepositoryProtocol
    init(repo: AuthRepositoryProtocol,
         session: SessionManager,
         router: AppRouter) {
        self.repo = repo
        self.session = session
        self.router = router
    }

    func signup() {
        guard validateFields() else { return }

        isLoading = true

        let user = User(
            id: UUID(),
            name: name,
            email: email,
            password: password
        )

        Task {
            do {
                let createdUser = try await repo.signup(user: user)

                self.signupSuccess = true
                self.loggedUser = createdUser

            } catch {
                self.errorMessage = error.localizedDescription
            }

            self.isLoading = false
        }
    }

    func login() {
        guard validateFields() else { return }

        isLoading = true

        Task {
            do {
                let user = try await repo.login(email: email, password: password)

                self.loggedUser = user
                self.session.user = user
                
            } catch {
                self.errorMessage = error.localizedDescription
            }

            self.isLoading = false
        }
    }
    /*
    func login() {
        guard validateFields() else { return }

        isLoading = true

        Task {
            do {
                try await repo.login(email: email, password: password)
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        self.isLoading = false
                        if case .failure(let error) = completion {
                            self.errorMessage = error.localizedDescription
                        }

                    } receiveValue: { user in
                        if !user.email.isEmpty {
                            self.loggedUser = user
                            self.router.push(.productList)
                            self.session.user = user
                            self.router.reset(to: .productList)
                            self.router.pop()
                        }

                    }
                    .store(in: &cancellables)
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }

    func signup() {
        guard validateFields() else { return }

        isLoading = true

        let user = User(
                    id: UUID(),
                    name: name,
                    email: email,
                    password: password
                )

        Task {
            do {
                try await repo.signup(user: user)
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        self.isLoading = false
                        if case .failure(let error) = completion {
                            self.errorMessage = error.localizedDescription
                    }

                    } receiveValue: { user in
                        self.signupSuccess = true
                        self.loggedUser = user
                        self.router.pop()
                    }
                    .store(in: &cancellables)

            } catch {
                isLoading = false
                self.errorMessage = error.localizedDescription
            }
        }
    }
    */
    private func validateFields() -> Bool {

        if password.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty || name.isEmpty {
            errorMessage = "All fields required"
            isLoading = false
            return false
        }

        if password.count < 4 {
            errorMessage = "Password must be at least 4 characters"
            isLoading = false
            return false
        }

        if password != confirmPassword {
            errorMessage = "Password not matching"
            isLoading = false
            return false
        }
        return true
    }

    func goToSignup() {
        router.push(.signup)
    }
}
