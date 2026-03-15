//
//  RootView.swift
//  OffLineLocallyDemo
//
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var session: SessionManager

    init() {
        setupNavigationBarAppearance()
    }
    
    var body: some View {

        NavigationStack {
            if session.isLoggedIn {
                HomeView(
                    viewModel: DependencyContainer.makeHomeViewModel(user: session.currentUser)
                )

            } else {
                LoginView(
                    viewModel: DependencyContainer.makeLoginViewModel()
                )
            }
        }
    }
    func setupNavigationBarAppearance() {

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.purple

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
#Preview {
    RootView()
}
