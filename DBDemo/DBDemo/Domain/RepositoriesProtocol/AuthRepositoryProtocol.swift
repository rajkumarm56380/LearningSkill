//
//  AuthRepositoryProtocol.swift
//  DBDemo
//
//
//

import Combine

protocol AuthRepositoryProtocolOld {
    func login(email: String, password: String) -> AnyPublisher<ItemModel, Error>
}

protocol AuthRepositoryProtocol {
    func login(email: String, password: String) throws
    func signup(email: String, password: String) throws
}
