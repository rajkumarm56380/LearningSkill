//
//  HomeView.swift
//  OffLineLocallyDemo
//
//

import SwiftUI
import SharedUIKits

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var router: AppRouter
    
    var body: some View {

        LazyVStack(spacing: 20) {
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
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(
                LinearGradient(
                    colors: [Color.pink, Color.purple],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(30)
            .padding(.horizontal)
        }
        .navigationTitle("Home Screen")
        .appNavigationStyle()
        .padding()
    }
}

