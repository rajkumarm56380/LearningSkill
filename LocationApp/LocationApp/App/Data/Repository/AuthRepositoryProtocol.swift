//
//  AuthRepositoryProtocol.swift
//  LocationApp
//
//  Created by Apple on 15/03/26.
//

import Foundation
import Combine

protocol AuthRepositoryProtocol {
    func signup(user: User) -> AnyPublisher<Bool, Error>
    func login(email: String, password: String) -> AnyPublisher<User?, Error>
}
