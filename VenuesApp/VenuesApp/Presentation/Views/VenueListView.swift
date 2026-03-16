//
//  VenueListView.swift
//  VenuesApp
//
//

import Combine
import SwiftUI

struct VenueListView: View {
    @StateObject var viewModel: VenueListViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }

                LazyVStack(spacing: 16) {
                    ForEach(viewModel.venuesList) { venue in
                        VenueCardView(venue: venue)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Nearby Venues")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.indigo, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .onAppear {
            viewModel.loadVenues()
        }
    }
}
