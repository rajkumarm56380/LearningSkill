//
//  HomeView.swift
//  LocationApp
//
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var session: SessionManager

    var body: some View {

        VStack(spacing: 20) {
            if let user = viewModel.user {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Name: \(user.name)")
                    Text("Email: \(user.email)")
                }
            }

            Button("Logout") {
                dismiss()
                viewModel.logout()
                session.logout()
            }
            .buttonStyle(.bordered)
        }
        .navigationBarTitle("Home Screen", displayMode: .large)
        .navigationBarBackButtonHidden(true)
        .padding()
    }
}

#Preview {
    let user = User(
                id: UUID(),
                name: "Raj",
                email: "raj@test.com",
                password: "1234",
                isLoggedIn: false
            )

    HomeView(viewModel: DependencyContainer.makeHomeViewModel(user: user))
}
