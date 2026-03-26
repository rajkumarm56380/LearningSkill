//
//  AuthServiceProtocol.swift
//  DemoOffLineDBApp
//
//

import Foundation
import Combine

protocol AuthServiceProtocol {

    func login(email: String, password: String) async throws -> User
    func signup(user: User) async throws -> User
    func logout() async throws
    func observeAuthState() -> AsyncStream<User?>
}
