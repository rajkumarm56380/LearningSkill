//
//  StateManagementApp.swift
//  StateManagement
//
//  Created by user on 26/02/26.
//

import SwiftUI

@main
struct StateManagementApp: App {
    @StateObject private var theme = ThemeManager()
        var body: some Scene {
            WindowGroup {
                CounterScreenView()
                    .environmentObject(theme)
            }
        }
}
