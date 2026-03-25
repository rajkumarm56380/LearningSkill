//
//  CartLocalDataSource.swift
//  DemoOffLineDBApp
//
//

import Foundation
import SwiftData

final class CartLocalDataSource {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(_ dtos: [ProductDTO]) {
        try? context.delete(model: ProductEntity.self)
        dtos.forEach {
            context.insert(CartEntity(id: $0.id,
                                      title: "Product \($0.id)",
                                      price: $0.price))
        }
        try? context.save()
    }

    func fetch() -> [Product] {
        let entities = (try? context.fetch(FetchDescriptor<ProductEntity>())) ?? []
        return entities.map {
            Product(id: $0.id, title: $0.title, price: $0.price, isFavorite: $0.isFavorite, quantity: $0.quantity)
        }
    }
}
