//
//  OffLineLocallyDemoApp.swift
//  OffLineLocallyDemo
//
//

import SwiftUI

@main
struct OffLineLocallyDemoApp: App {
    @StateObject private var sessionManager = SessionManager()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(sessionManager)
        }
    }
}
