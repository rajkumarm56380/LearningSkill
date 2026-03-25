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
    var total: Double
    var discountPercentage: Double
    var discountedTotal:  Double
    var thumbnail: String

    init(id: Int, title: String, price: Double, isFavorite: Bool, quantity: Int, total: Double, discountPercentage: Double, discountedTotal: Double, thumbnail: String) {
        self.id = id
        self.title = title
        self.price = price
        self.isFavorite = isFavorite
        self.quantity = quantity
        self.total = total
        self.discountPercentage = discountPercentage
        self.discountedTotal = discountedTotal
        self.thumbnail = thumbnail
    }
}
