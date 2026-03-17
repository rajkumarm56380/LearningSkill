//
//  AuthViewModel.swift
//  DBDemo
//
//
//

import Combine

final class AuthViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var isLoggedIn = false
    @Published var error: String?

    private let loginUseCase: LoginUseCase
    private let signupUseCase: SignupUseCase

    init(container: DependencyContainer) {
        self.loginUseCase = container.loginUseCase
        self.signupUseCase = container.signupUseCase
    }

    func login() {
        do {
            try loginUseCase.execute(email: email, password: password)
            isLoggedIn = true
        } catch {
            self.error = "Login Failed"
        }
    }

    func signup() {
        do {
            try signupUseCase.execute(email: email, password: password)
            isLoggedIn = true
        } catch {
            self.error = "Signup Failed"
        }
    }
}
