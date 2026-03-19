//
//  DependencyContainer.swift
//  DemoOffLineDBApp
//
//

import Foundation

@MainActor
final class DependencyContainer {

    // MARK: Shared Services
    static let sessionManager = SessionManager()

    // MARK: - Storage
    static var storage = UserStorage()

    // MARK: - Repository
    private static let authRepository = AuthRepository(storage: storage)

    // MARK: - UseCases
    static func makeLoginUseCase() -> LoginUseCase {
        LoginUseCase(repo: authRepository)
    }

    static func makeSignupUseCase() -> SignupUseCase {
        SignupUseCase(repo: authRepository)
    }

    // MARK: - ViewModels

    static func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(
            loginUseCase: makeLoginUseCase(),
            sessionManager: sessionManager
        )
    }

    static func makeSignupViewModel() -> SignupViewModel {
        SignupViewModel(
            signupUseCase: makeSignupUseCase(),
            sessionManager: sessionManager
        )
    }

    static func makeHomeViewModel(user: User?) -> HomeViewModel {
        HomeViewModel(user: user)
    }

}
