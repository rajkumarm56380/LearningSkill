//
//  DemoVenuesApp.swift
//  DemoVenuesApp
//
// 
//

import SwiftUI

@main
struct DemoVenuesApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                VenueListView(viewModel: DependencyContainer.shared.makeVenueListViewModel())
            }
        }
    }
}
