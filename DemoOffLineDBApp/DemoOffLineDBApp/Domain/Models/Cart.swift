//
//  Cart.swift
//  DemoOffLineDBApp
//
//

// MARK: - DOMAIN MODELS

struct Cart: Identifiable, Hashable {
    let id: Int
    let title: String
    let price: Double
}
