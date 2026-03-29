//
//  VenueListView.swift
//  DemoVenuesApp
//
//

import Combine
import SwiftUI
import SharedUIKits

struct VenueListView: View {
    @StateObject var viewModel: VenueListViewModel

    var body: some View {
        ZStack { 
            ScrollView {
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
        .loading(viewModel.isLoading)
        .task {
            viewModel.loadVenues()
        }
    }
}
