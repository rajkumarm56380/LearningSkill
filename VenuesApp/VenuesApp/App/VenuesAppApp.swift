//
//  VenuesAppApp.swift
//  VenuesApp
//
//

import SwiftUI

@main
struct VenuesAppApp: App {
    var body: some Scene {
        WindowGroup {
            VenueListView(viewModel: DependencyContainer.shared.makeVenueListViewModel())
        }
    }
}
