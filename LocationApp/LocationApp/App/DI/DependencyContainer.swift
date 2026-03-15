//
//  DependencyContainer.swift
//  LocationApp
//
//  Created by Apple on 15/03/26.
//

import Foundation
class DependencyContainer {

    static func makeLoginViewModel() -> LoginViewModel {

        let storage = UserStorage()
        let repo = AuthRepository(storage: storage)
        let useCase = LoginUseCase(repo: repo)

        return LoginViewModel(loginUseCase: useCase)
    }
}
