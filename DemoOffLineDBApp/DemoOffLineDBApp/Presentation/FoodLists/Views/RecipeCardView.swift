//
//  RecipeCardView.swift
//  DemoOffLineDBApp
////

import SwiftUI
import SharedUIKits

struct RecipeCardView: View {

    let recipe: Recipe

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 8) {

            SDWebImageView(imageUrl: recipe.image)
                .scaledToFit()
                .frame(height: 140)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(12)
            Text(recipe.name)
                .font(.headline)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Label("\(recipe.rating, specifier: "%.1f")", systemImage: "star.fill")
                    .foregroundColor(.orange)
                Text("(\(recipe.reviewCount))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }.foregroundColor(.black)
            HStack {
                Text("Recipe Type:")
                    .font(.caption)
                Text(recipe.difficulty)
                    .font(.caption)
                    .padding(6)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(8)
            }.foregroundColor(.black)

            VStack {
                Label("\(recipe.prepTimeMinutes + recipe.cookTimeMinutes) min", systemImage: "clock")
                Label(recipe.cuisine, systemImage: "fork.knife")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 3)
    }
}
