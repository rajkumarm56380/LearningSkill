//
//  SignupViewModel.swift
//  DemoCombine
//
//  Created by Apple on 02/03/26.
//
import Combine
import Foundation

@MainActor
final class SignupViewModel: ObservableObject {

    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isSignedUp = false

    private let signupUseCase: SignupUseCase
    private var cancellables = Set<AnyCancellable>()

    init(signupUseCase: SignupUseCase) {
        self.signupUseCase = signupUseCase
    }

    func signup() {

        signupUseCase.execute(
            name: name,
            email: email,
            password: password
        )
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            },
            receiveValue: { [weak self] _ in
                self?.isSignedUp = true
            }
        )
        .store(in: &cancellables)
    }
}
