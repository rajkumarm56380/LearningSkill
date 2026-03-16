//
//  LocationAppApp.swift
//  LocationApp
//
//

import SwiftUI

@main
struct LocationAppApp: App {
    var body: some Scene {
        WindowGroup {
            MapView(
                viewModel: DependencyContainer.makeMapViewModel()
            )
        }
    }
}
