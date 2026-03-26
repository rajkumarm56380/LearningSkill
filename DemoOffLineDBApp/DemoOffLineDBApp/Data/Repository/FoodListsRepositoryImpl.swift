//
//  FoodListsRepositoryImpl.swift
//  DemoOffLineDBApp
//
//

import Foundation
import Combine

final class FoodListsRepositoryImpl: FoodListsRepositoryProtocol {

    private let sync: SyncManager

    init(sync: SyncManager) {
        self.sync = sync
    }

    func fetch() -> AnyPublisher<[Recipe], APIError> {
        sync.fetchProducts()
    }
}
