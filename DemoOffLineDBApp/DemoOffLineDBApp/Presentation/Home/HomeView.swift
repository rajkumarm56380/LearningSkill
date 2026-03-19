//
//  HomeView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var router: Router

    var body: some View {

        VStack(spacing: 20) {
            if let user = viewModel.user {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Name: \(user.name)")
                    Text("Email: \(user.email)")
                }
            }

            Button("Logout") {
                viewModel.logout()
                session.logout()
                router.popToRoot()
            }
            .buttonStyle(.bordered)
        }
        .navigationTitle("Home Screen")
        .appNavigationStyle()
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
