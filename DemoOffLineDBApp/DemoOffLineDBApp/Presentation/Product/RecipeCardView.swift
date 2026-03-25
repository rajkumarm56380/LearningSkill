//
//  RecipeCardView.swift
//  DemoOffLineDBApp
////

import SwiftUI

struct RecipeCardView: View {

    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            AsyncImage(url: URL(string: recipe.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(height: 180)
            .clipped()
            .cornerRadius(12)

            Text(recipe.name)
                .font(.headline)
                .lineLimit(2)

            HStack {
                Label("\(recipe.rating, specifier: "%.1f")", systemImage: "star.fill")
                    .foregroundColor(.orange)

                Text("(\(recipe.reviewCount))")
                    .font(.caption)
                    .foregroundColor(.gray)

                Spacer()

//                Text(recipe.difficulty)
//                    .font(.caption)
//                    .padding(6)
//                    .background(Color.green.opacity(0.2))
//                    .cornerRadius(8)
            }

            HStack {
                Text("\(recipe.prepTimeMinutes + recipe.cookTimeMinutes) min")
                Spacer()
                Text(recipe.cuisine)
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 3)
    }
}
