//
//  ProductDetailView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        VStack {
            Text(product.title)
            Text("₹ \(product.price)")
        }
    }
}
