//
//  CartEntity.swift
//  DemoOffLineDBApp
//
//

import SwiftData

@Model
final class CartEntity {
    @Attribute(.unique) var id: Int
    var title: String
    var price: Double

    init(id: Int, title: String, price: Double) {
        self.id = id
        self.title = title
        self.price = price
    }
}
