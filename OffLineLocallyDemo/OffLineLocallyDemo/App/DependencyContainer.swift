//
//  DependencyContainer.swift
//  OffLineLocallyDemo
//
//

import Foundation

@MainActor
final class DependencyContainer: ObservableObject {

    // MARK: Shared Services
    lazy var sessionManager = SessionManager()
    let router = AppRouter()

    // MARK: - Storage
    lazy var storage = UserStorage()

    // MARK: - Repository
    lazy var authRepository = AuthRepository(storage: storage)

    // MARK: - UseCases
    lazy var makeLoginUseCase = LoginUseCase(repo: authRepository)
    lazy var makeSignupUseCase = SignupUseCase(repo: authRepository)

    // MARK: - ViewModels

    func makeLoginVM() -> LoginViewModel {
        LoginViewModel(loginUseCase: makeLoginUseCase, sessionManager: sessionManager)
    }

    func makeSignupVM() -> SignupViewModel {
        SignupViewModel(signupUseCase: makeSignupUseCase, sessionManager: sessionManager)
    }

    func makeHomeViewModel() -> HomeViewModel {
       HomeViewModel(session: sessionManager)
   }

}
