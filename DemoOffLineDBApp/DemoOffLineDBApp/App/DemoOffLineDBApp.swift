//
//  DemoOffLineDBApp.swift
//  DemoOffLineDBApp
//
//

import SwiftUI
import FirebaseCore

@main
struct DemoOffLineDBApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var container = DependencyContainer()

    var body: some Scene {
        WindowGroup {
            RootView(container: container)
                .environmentObject(container.router)
                .environmentObject(container.session)
        }
    }
}
