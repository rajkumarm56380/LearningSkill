//
//  ProductRepositoryImpl.swift
//  DemoOffLineDBApp
//
//

import Foundation
import Combine

final class ProductRepositoryImpl: ProductRepositoryProtocol {

    private let sync: SyncManager

    init(sync: SyncManager) {
        self.sync = sync
    }

    func fetch() -> AnyPublisher<[Recipe], APIError> {
        sync.fetchProducts()
    }
}
