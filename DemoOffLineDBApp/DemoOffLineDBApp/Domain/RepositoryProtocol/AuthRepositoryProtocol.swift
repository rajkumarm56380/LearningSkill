//
//  AuthRepositoryProtocol.swift
//  DemoOffLineDBApp
//
//
import Combine

protocol AuthRepositoryProtocol {
    func signup(user: User) async throws -> User
    func login(email: String, password: String) async throws -> User
    func logout() async throws
    func getCurrentUser() -> User?
}


