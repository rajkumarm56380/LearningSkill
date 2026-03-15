//
//  OffLineLocallyDemoApp.swift
//  OffLineLocallyDemo
//
//  Created by user on 13/03/26.
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
