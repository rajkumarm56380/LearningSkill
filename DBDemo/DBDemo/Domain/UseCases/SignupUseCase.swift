//
//  SignupUseCase.swift
//  DBDemo
//
//
//

import Foundation

final class SignupUseCase {
    let repo: AuthRepositoryProtocol
    init(repo: AuthRepositoryProtocol) { self.repo = repo }
    func execute(email: String, password: String) throws {
        try repo.signup(email: email, password: password)
    }
}
