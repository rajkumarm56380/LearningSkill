//
//  ProductDTO.swift
//  DemoOffLineDBApp
//
 
//

import Foundation

struct ProductResponse: Decodable {
    let products: [ProductDTO]
}

struct ProductDTO: Decodable {

    let id: Int
    let title: String
    let price: Double
    let quantity: Int
    let total, discountPercentage, discountedTotal: Double
    let thumbnail: String
    var isFavorite: Bool

    func toDomain() -> Product {
        Product(id: id, title: title, price: price, quantity: quantity, total: total, discountPercentage: discountPercentage, discountedTotal: discountedTotal, thumbnail: thumbnail, isFavorite: isFavorite)
    }
}
