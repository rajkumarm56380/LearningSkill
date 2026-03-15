//
//  LoginViewModel.swift
//  LocationApp
//
//

import Combine
import Foundation

@MainActor
class LoginViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""

    @Published var isLoading = false
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    @Published var loggedUser: User?

    private let sessionManager: SessionManager
    private let loginUseCase: LoginUseCase
    private var cancellables = Set<AnyCancellable>()

    init(
        loginUseCase: LoginUseCase,
        sessionManager: SessionManager
    ) {
        self.loginUseCase = loginUseCase
        self.sessionManager = sessionManager
    }

    func login() {

        isLoading = true

        loginUseCase.execute(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }

            } receiveValue: { user in
                if let user = user {
                    self.loggedUser = user
                    self.isLoggedIn = true
                    self.sessionManager.login(user: user)
                }
            }
            .store(in: &cancellables)
    }
}
