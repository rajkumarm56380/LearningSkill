//
//  UserRepository.swift
//  DemoCombine
//
//  Created by user on 02/03/26.
//

import Combine

protocol UserRepositoryProtocol {
    func login(email: String, password: String) -> AnyPublisher<User, Error>
    func signup(name: String, email: String, password: String) -> AnyPublisher<User, Error>
    func fetchUsers() -> AnyPublisher<[User], Error>
}
