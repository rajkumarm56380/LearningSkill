//
//  SignupViewModel.swift
//  OffLineLocallyDemo
//
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class SignupViewModel: ObservableObject {

    @Published var name = ""
    @Published var email = ""
    @Published var password = ""

    @Published var isLoading = false
    @Published var signupSuccess = false
    @Published var shouldNavigateToLogin = false
    @Published var errorMessage: String?
    @Published var loggedUser: User?

    private let sessionManager: SessionManager
    private let signupUseCase: SignupUseCase
    private var cancellables = Set<AnyCancellable>()

    init(
        signupUseCase: SignupUseCase,
        sessionManager: SessionManager
    ) {
        self.signupUseCase = signupUseCase
        self.sessionManager = sessionManager
    }

    func signup() {

        guard validateFields() else { return }

        isLoading = true

        let user = User(
            id: UUID(),
            name: name,
            email: email,
            password: password,
            isLoggedIn: true
        )

        signupUseCase.execute(user: user)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                self.sessionManager.isLoggedIn = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
            }

            } receiveValue: { success in
                self.signupSuccess = success
                self.loggedUser = user

                self.sessionManager.login(user: user)
                if success {
                    self.shouldNavigateToLogin = true
                }
            }
            .store(in: &cancellables)
    }

    private func validateFields() -> Bool {

        if name.isEmpty || email.isEmpty || password.isEmpty {
            errorMessage = "All fields required"
            return false
        }

        if password.count < 4 {
            errorMessage = "Password must be at least 4 characters"
            return false
        }

        return true
    }
}
