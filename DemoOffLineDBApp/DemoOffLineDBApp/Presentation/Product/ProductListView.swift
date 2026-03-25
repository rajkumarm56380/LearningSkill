//
//  CartListView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct ProductListView: View {

    @ObservedObject var viewModel: ProductListViewModel
    @EnvironmentObject var router: AppRouter

    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.recipes) { recipe in
                        Button {
                            router.push(.recipeDetail(recipe))
                        } label: {
                            RecipeCardView(recipe: recipe)
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                viewModel.load()
            }
            .navigationTitle("Food Recipes")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsView()) { 
                        Image(systemName: "gear")
                    }
                }
            }
            
            .appNavigationStyle()
        }
    }
}
