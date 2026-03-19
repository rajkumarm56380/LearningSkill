//
//  OffLineLocallyDemoApp.swift
//  OffLineLocallyDemo
//
//

import SwiftUI

@main
struct OffLineLocallyDemoApp: App {
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
