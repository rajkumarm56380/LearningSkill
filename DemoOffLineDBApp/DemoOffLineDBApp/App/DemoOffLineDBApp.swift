//
//  DemoOffLineDBApp.swift
//  DemoOffLineDBApp
//
//

import SwiftUI
import SwiftData

@main
struct DemoOffLineDBApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @StateObject private var sessionManager = SessionManager()
    @StateObject private var router = Router()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(sessionManager)
                .environmentObject(router)
        }
    }
}
