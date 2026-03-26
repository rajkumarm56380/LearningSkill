//
//  FoodListsView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct FoodListsView: View {

    @ObservedObject var viewModel: FoodListsViewModel
    @EnvironmentObject var router: AppRouter

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.recipes, id: \.id) { recipe in
                            Button {
                                router.push(.recipeDetail(recipe))
                            } label: {
                                RecipeCardView(recipe: recipe)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
            .background(Color(.systemGray6))
            .navigationTitle("Food Lists").foregroundColor(.white)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        router.push(.settings)
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
            .appNavigationStyle()
            .loading(viewModel.isLoading)
            .task {
                viewModel.load()
            }
    }
}
