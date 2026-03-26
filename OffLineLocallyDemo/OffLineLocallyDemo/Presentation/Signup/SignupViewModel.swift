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
    @Published var confirmPassword = ""
    
    @Published var isLoading = false
    @Published var signupSuccess = false
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
            }
            .store(in: &cancellables)
    }

    private func validateFields() -> Bool {

        if password.isEmpty || email.isEmpty || confirmPassword.isEmpty || name.isEmpty {
            errorMessage = "All fields required"
            isLoading = false
            return false
        }

        if password.count < 6 {
            errorMessage = "Password must be at least 6 characters"
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
