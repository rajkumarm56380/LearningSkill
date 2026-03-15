//
//  VenueListView.swift
//  VenuesApp
//
//  Created by Apple on 14/03/26.
//

import SwiftUI

struct VenueListView: View {
    @StateObject var viewModel: VenueListViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                }
                /*List(viewModel.veneusList, id: \.id) { venue in
                    VStack(alignment: .leading) {
                        Text(venue.displayName)
                            .font(.headline)
                        Text("\(venue.distance) km away")
                            .font(.caption)
                    }
                }*/
            }
            .navigationTitle("Nearby Venues")
            .onAppear {
                viewModel.loadVenues()
            }
        }
    }
}
