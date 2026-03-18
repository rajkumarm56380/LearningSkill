//
//  DemoLocationApp.swift
//  LocationApp
//
//

import SwiftUI

@main
struct DemoLocationApp: App {
    var body: some Scene {
        WindowGroup {
            MapView(
                viewModel: DependencyContainer().makeMapViewModel()
            )
        }
    }
}

