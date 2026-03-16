//
//  VenueCardView.swift
//  VenuesApp
//
//  Created by Apple on 16/03/26.
//

import SwiftUI

struct VenueCardView: View {
    let venue: LocalResult

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                AsyncImage(url: URL(string: venue.images.first ?? MockImage.imageUrl.rawValue)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 110, height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                VStack(alignment: .leading, spacing: 6) {

                    Text(venue.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("\(venue.description)")
                        .font(.subheadline)
                }
            }

            Divider()

            VStack(alignment: .leading, spacing: 4) {

                Text("Address: \(venue.address)")
                Text(venue.hours)

                HStack {
                    Text("Reviews: \(venue.reviews)")
                    Text("Rating: \(venue.rating)")
                }
            }
            .font(.subheadline)

        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 3)
        )
        .padding(.horizontal)
    }
}

