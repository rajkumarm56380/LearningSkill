//
//  LoginUseCase.swift
//  DBDemo
//
//
//

import Combine

final class LoginUseCase {
    let repo: AuthRepositoryProtocol
    init(repo: AuthRepositoryProtocol) { self.repo = repo }
    func execute(email: String, password: String) throws {
        try repo.login(email: email, password: password)
    }
}
