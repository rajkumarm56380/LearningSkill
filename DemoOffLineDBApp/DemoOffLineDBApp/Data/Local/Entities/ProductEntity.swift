//
//  ProductEntity.swift
//  DemoOffLineDBApp
//
//

import SwiftData

@Model
final class ProductEntity {

    @Attribute(.unique) var id: Int
    var title: String
    var price: Double
    var isFavorite: Bool
    var quantity: Int

    init(id: Int,
         title: String,
         price: Double,
         isFavorite: Bool = false,
         quantity: Int = 0) {
        self.id = id
        self.title = title
        self.price = price
        self.isFavorite = isFavorite
        self.quantity = quantity
    }
}
