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
        guard validateAllFields() else { return }

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
                self.loggedUser = createdUser
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }

    func login() {
        guard loginFieldsValidate() else { return }

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

    private func loginFieldsValidate() -> Bool {

        if password.isEmpty || email.isEmpty {
            errorMessage = "All fields required!"
            isLoading = false
            return false
        }

        if password.isEmpty {
            errorMessage = "Password is missing!"
            isLoading = false
            return false
        }

        if password.count < 5 {
            errorMessage = "Password must be at least 5 characters"
            isLoading = false
            return false
        }

        return true
    }

    private func validateAllFields() -> Bool {

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

}
