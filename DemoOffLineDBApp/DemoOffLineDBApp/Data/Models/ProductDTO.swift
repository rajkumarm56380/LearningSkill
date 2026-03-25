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
    var isFavorite: Bool
    var quantity: Int

    func toDomain() -> Product {
        Product(id: id, title: "Prouct \(id)", price: price, isFavorite: false, quantity: 1)
    }
}
