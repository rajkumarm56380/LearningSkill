//
//  VenueCardView.swift
//  DemoVenuesApp
//
//

import SwiftUI

struct VenueCardView: View {
    let venue: LocalResult

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                CachedAsyncImage(
                    url: venue.images.first ?? MockImage.imageUrl.rawValue
                )
                .frame(width: 110, height: 110)
                .clipped()
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

