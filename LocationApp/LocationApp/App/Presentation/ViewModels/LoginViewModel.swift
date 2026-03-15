//
//  LoginViewModel.swift
//  LocationApp
//
//  Created by Apple on 15/03/26.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""

    @Published var isLoading = false
    @Published var isLoggedIn = false
    @Published var errorMessage: String?

    private let loginUseCase: LoginUseCase
    private var cancellables = Set<AnyCancellable>()

    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
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

                self.isLoggedIn = user != nil
            }
            .store(in: &cancellables)
    }
}
