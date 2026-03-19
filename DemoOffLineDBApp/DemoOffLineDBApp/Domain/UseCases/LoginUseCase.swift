//
//  LoginUseCase.swift
//  DemoOffLineDBApp
//
//

import Combine
import Foundation

final class LoginUseCase {

    private let repo: AuthRepositoryProtocol

    init(repo: AuthRepositoryProtocol) {
        self.repo = repo
    }

    func execute(email: String, password: String) -> AnyPublisher<User?, Error> {
        repo.login(email: email, password: password)
    }
}
