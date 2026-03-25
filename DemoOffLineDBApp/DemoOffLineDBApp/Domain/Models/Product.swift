//
//  Product.swift
//  DemoOffLineDBApp
//

//

import Foundation

struct ProductOld: Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
    var isFavorite: Bool
    var quantity: Int
}
