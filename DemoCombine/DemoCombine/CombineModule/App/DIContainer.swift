//
//  DIContainer.swift
//  DemoCombine
//
//  Created by Apple on 02/03/26.
//

import Foundation

final class DIContainer {

    static let shared = DIContainer()

    private let repository: UserRepositoryProtocol = UserRepository()

    @MainActor func makeSignupVM() -> SignupViewModel {
        SignupViewModel(
            signupUseCase: SignupUseCase(repository: repository)
        )
    }

    @MainActor func makeLoginVM() -> LoginViewModel {
        LoginViewModel(
            loginUseCase: LoginUseCase(repository: repository)
        )
    }

    @MainActor func makeUserListVM() -> UserListViewModel {
        UserListViewModel(
            fetchUsersUseCase: FetchUsersUseCase(repository: repository)
        )
    }
}
