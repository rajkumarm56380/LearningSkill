//
//  OffLineLocallyDemoApp.swift
//  OffLineLocallyDemo
//
//

import SwiftUI

@main
struct OffLineLocallyDemoApp: App {
    @StateObject private var container = DependencyContainer()

    var body: some Scene {
        WindowGroup {
            RootView(container: container)
                .environmentObject(container.sessionManager)
                .environmentObject(container.router)
        }
    }
}
