//
//  SignupUseCase.swift
//  LocationApp
//
//

import Combine
import Foundation

final class SignupUseCase {

    private let repo: AuthRepositoryProtocol

    init(repo: AuthRepositoryProtocol) {
        self.repo = repo
    }

    func execute(user: User) -> AnyPublisher<Bool, Error> {
        repo.signup(user: user)
    }
}
