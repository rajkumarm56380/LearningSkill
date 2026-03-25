//
//  SettingsView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var session: SessionManager

    var body: some View {
        VStack(spacing: 20) {
            
        }.padding()
        .navigationTitle("Settings")
        .navigationBarBackButtonHidden(false)
        .appNavigationStyle()
    }
}

#Preview {
    SettingsView()
}
