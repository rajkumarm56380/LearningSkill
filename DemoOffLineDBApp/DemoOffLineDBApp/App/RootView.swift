//
//  RootView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct RootView: View {

    let container: DependencyContainer
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var router: AppRouter

    var body: some View {

        NavigationStack(path: $router.path) {

            Group {
                if session.isLoggedIn {
                    ProductListView(viewModel: container.makeCartVM())
                } else {
                    LoginView(viewModel: container.makeAuthVM())
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .recipeDetail(let recipe):
                    RecipeDetailView(recipe: recipe)
                case .productList:
                    ProductListView(viewModel: container.makeCartVM())
                case .login:
                    LoginView(viewModel: container.makeAuthVM())
                case .signup:
                    SignupView(viewModel: container.makeAuthVM())
                case .settings:
                    SettingsView()
                }
            }
        }
    }
}
