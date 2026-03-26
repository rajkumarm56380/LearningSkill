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
    @State private var showSplash = true

    var body: some View {

        NavigationStack(path: $router.path) {

            Group {
                if showSplash {
                    SplashView()
                } else {
                    if session.isLoggedIn {
                        FoodListsView(viewModel: container.foodListsVM)
                    } else {
                        LoginView(viewModel: container.makeAuthVM())
                    }
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .recipeDetail(let recipe):
                    RecipeDetailView(recipe: recipe)
                case .foodLists:
                    FoodListsView(viewModel: container.foodListsVM)
                case .login:
                    LoginView(viewModel: container.makeAuthVM())
                case .signup:
                    SignupView(viewModel: container.makeAuthVM())
                case .settings:
                    SettingsView()
                }
            }.onAppear {
                startSplash()
            }
        }
    }

    private func startSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showSplash = false
        }
    }
}
