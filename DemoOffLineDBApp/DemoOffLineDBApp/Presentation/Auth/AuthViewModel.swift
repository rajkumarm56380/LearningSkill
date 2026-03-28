//
//  AuthViewModel.swift
//  DemoOffLineDBApp
//
//

import Foundation
import Combine

@MainActor
final class AuthViewModel: ObservableObject {

    //Property Wrapper
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
    private let repo: AuthUseCaseProtocol

    init(repo: AuthUseCaseProtocol,
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
                let createdUser = try await repo.executeSignup(user: user)
                self.loggedUser = createdUser
                session.setUser(user) 
                self.router.reset(to: .foodLists)
            } catch let error as AuthError {
                self.errorMessage = error.localizedDescription
            } catch {
                self.errorMessage = "Unexpected error"
            }
            self.isLoading = false
        }
    }

    func login() {
        guard loginFieldsValidate() else { return }

        isLoading = true

        Task {
            do {
                let user = try await repo.executeLogin(email: email, password: password)
                self.loggedUser = user
                session.setUser(user)
                self.router.reset(to: .foodLists)
            } catch let error as AuthError {
                self.errorMessage = error.localizedDescription
            } catch {
                self.errorMessage = "Unexpected error"
            }
            self.isLoading = false
        }
    }

    func logout() {
        Task {
            do {
                try await repo.executeLogout()
                session.clearUser()          // await actor call
                self.loggedUser = nil
                self.router.reset(to: .login)
            } catch let error as AuthError {
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func loginFieldsValidate() -> Bool {
        // ResultBuilder
        let error = Validator.validate {
            EmailRule(email)
            PasswordRule(password)
        }

        if let error = error {
            errorMessage = error
            return false
        }

        return true
    }

    private func validateAllFields() -> Bool {
        // ResultBuilder
        let error = Validator.validate {
            NameRule(name)
            EmailRule(email)
            PasswordRule(password)
            ConfirmPasswordRule(password: password, confirm: confirmPassword)
        }

        if let error = error {
            errorMessage = error
            return false
        }

        return true
    }

}
