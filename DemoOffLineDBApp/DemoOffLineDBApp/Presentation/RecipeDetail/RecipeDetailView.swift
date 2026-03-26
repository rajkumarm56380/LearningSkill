//
//  RecipeDetailView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @State private var isFavourite: Bool = false
    @EnvironmentObject var router: AppRouter

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
                HStack {
                    Text(recipe.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    /*Button(action: {
                     isFavourite.toggle()
                     }) {
                     Image(systemName: isFavourite ? "heart.fill" : "heart")
                     .foregroundColor(isFavourite ? .red : .gray)
                     .font(.title2)
                     }*/
                }
                
                // Recipe Info
                HStack(spacing: 20) {
                    Label("\(recipe.rating) ★ (\(recipe.reviewCount))", systemImage: "star.fill")
                        .foregroundColor(.yellow)
                    Label("\(recipe.prepTimeMinutes + recipe.cookTimeMinutes) min", systemImage: "clock")
                    Label(recipe.cuisine, systemImage: "fork.knife")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                // Description
                /*Text("A classic Italian pizza topped with fresh mozzarella, basil, and tomato sauce. Perfectly baked for a crispy crust and rich flavor.")
                 .font(.body)
                 .padding(.bottom, 20)*/
                
                // Ingredients Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ingredients")
                        .font(.headline)
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Text("• \(ingredient)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Divider()
                
                // Instructions Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Instructions")
                        .font(.headline)
                    ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, step in
                        Text("\(index + 1). \(step)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding()
            .foregroundColor(.black)
        }
        .navigationTitle("Food Detail").foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    router.popLast()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                    }
                }
            }
        }
        .appNavigationStyle()
    }
}
