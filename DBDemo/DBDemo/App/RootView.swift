//
//  RootView.swift
//  DBDemo
//
//

import SwiftUI

struct RootView: View {
    @StateObject var session = SessionManager.shared

    var body: some View {
        if session.isLoggedIn {
            HomeView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    RootView()
}
