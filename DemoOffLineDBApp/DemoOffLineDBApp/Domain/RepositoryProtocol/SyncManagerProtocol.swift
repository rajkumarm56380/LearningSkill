//
//  SyncManagerProtocol.swift
//  DemoOffLineDBApp
//
//

import Combine

protocol SyncManagerProtocol: AnyObject {
    func fetchProducts() -> AnyPublisher<[Recipe], APIError>
}
