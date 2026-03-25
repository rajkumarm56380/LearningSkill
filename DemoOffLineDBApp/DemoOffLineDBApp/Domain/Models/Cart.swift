//
//  Cart.swift
//  DemoOffLineDBApp
//
//

// MARK: - DOMAIN MODELS

import Foundation

// MARK: - Products
struct Products: Codable {
    let carts: [Cart]
    let total, skip, limit: Int
}

// MARK: - Cart
struct Cart: Codable,Identifiable, Hashable {
    let id: Int
    let products: [Product]
    let total, discountedTotal: Double
    let userID, totalProducts, totalQuantity: Int

    enum CodingKeys: String, CodingKey {
        case id, products, total, discountedTotal
        case userID = "userId"
        case totalProducts, totalQuantity
    }
}

// MARK: - Product
struct Product: Codable,Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let quantity: Int
    let total, discountPercentage, discountedTotal: Double
    let thumbnail: String
    var isFavorite: Bool
}
