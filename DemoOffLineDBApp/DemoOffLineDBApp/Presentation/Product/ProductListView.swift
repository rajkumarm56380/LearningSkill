//
//  CartListView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct ProductListView: View {

    @ObservedObject var viewModel: ProductListViewModel
    @EnvironmentObject var router: AppRouter

    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.products) { product in
                    Button {
                        router.push(.productDetail(product))
                    } label: {
                        Text(product.title)
                    }
                }
            }
            .navigationTitle("Product List")
            .onAppear { viewModel.load() }
            .navigationBarBackButtonHidden(true)
            .appNavigationStyle()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsView()) { 
                        Image(systemName: "gear")
                    }
                }
            }
        }
    }
}
