//
//  LoginViewModelswift.swift
//  DemoCombine
//
//  Created by Apple on 02/03/26.
//
import Combine
import Foundation

@MainActor
final class LoginViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoggedIn = false

    private let loginUseCase: LoginUseCase
    private var cancellables = Set<AnyCancellable>()

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }

    func login() {
        loginUseCase.execute(email: email, password: password)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] _ in
                    self?.isLoggedIn = true
                }
            )
            .store(in: &cancellables)
    }
}
