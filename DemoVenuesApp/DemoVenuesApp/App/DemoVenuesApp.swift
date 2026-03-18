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
            VenueListView(viewModel: DependencyContainer.shared.makeVenueListViewModel())
        }
    }
}
