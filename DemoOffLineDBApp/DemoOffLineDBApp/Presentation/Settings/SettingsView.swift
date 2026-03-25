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
            Text("Settings View Content")
            Button(action: {
                print("Logout")
                router.push(.login)
                session.logout()
            }) {
                Text("Logout")
                 .applyButtonStyle()
            }
        }.padding()
        .navigationTitle("Settings")
        .appNavigationStyle()

    }
}

#Preview {
    SettingsView()
}
