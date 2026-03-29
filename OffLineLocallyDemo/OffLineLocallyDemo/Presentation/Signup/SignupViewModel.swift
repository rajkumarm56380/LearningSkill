//
//  SignupViewModel.swift
//  OffLineLocallyDemo
//
//

import Combine
import SharedUIKits
import Foundation

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
