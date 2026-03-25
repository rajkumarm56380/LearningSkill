//
//  Product.swift
//  DemoOffLineDBApp
//

//

import Foundation

struct Product: Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
    var isFavorite: Bool
    var quantity: Int
}
