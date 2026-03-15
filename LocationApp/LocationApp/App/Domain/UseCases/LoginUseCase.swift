//
//  LoginUseCase.swift
//  LocationApp
//
//  Created by Apple on 15/03/26.
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
