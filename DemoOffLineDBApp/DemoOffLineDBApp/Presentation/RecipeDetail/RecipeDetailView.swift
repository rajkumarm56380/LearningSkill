//
//  ProductDetailView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @State private var isFavourite: Bool = false
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    CachedAsyncImage(
                        url: recipe.image
                    )
                    .clipped()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    // Title and Favourite Button
                    HStack {
                        Text("Classic Margherita Pizza")
                            .font(.title)
                            .fontWeight(.bold)

                        Spacer()

                        Button(action: {
                            isFavourite.toggle()
                        }) {
                            Image(systemName: isFavourite ? "heart.fill" : "heart")
                                .foregroundColor(isFavourite ? .red : .gray)
                                .font(.title2)
                        }
                    }

                    // Recipe Info
                    HStack(spacing: 20) {
                        Label("4.6 ★ (98)", systemImage: "star.fill")
                            .foregroundColor(.yellow)
                        Label("35 min", systemImage: "clock")
                        Label("Italian", systemImage: "fork.knife")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                    Divider()

                    // Description
                    Text("A classic Italian pizza topped with fresh mozzarella, basil, and tomato sauce. Perfectly baked for a crispy crust and rich flavor.")
                        .font(.body)
                        .padding(.bottom, 20)

                    // Ingredients Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ingredients")
                            .font(.headline)
                        Text("• Pizza dough\n• Tomato sauce\n• Fresh mozzarella\n• Basil leaves\n• Olive oil")
                    }

                    Divider()

                    // Instructions Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Instructions")
                            .font(.headline)
                        Text("1. Preheat oven to 220°C.\n2. Spread tomato sauce on dough.\n3. Add mozzarella and basil.\n4. Drizzle olive oil.\n5. Bake for 12–15 minutes.")
                    }
                }
                .padding()
            }
            .navigationTitle("Food Detail")
            .navigationBarTitleDisplayMode(.inline)
        }
}
