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
                if session.isLoggedIn {
                    FoodListsView(viewModel: container.foodListsVM)
                } else {
                    LoginView(viewModel: container.makeAuthVM())
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .login:
                    LoginView(viewModel: container.makeAuthVM())
                case .signup:
                    SignupView(viewModel: container.makeAuthVM())
                case .foodLists:
                    FoodListsView(viewModel: container.foodListsVM)
                case .settings:
                    SettingsView()
                case .recipeDetail(let recipe):
                    RecipeDetailView(recipe: recipe)
                default:
                        EmptyView()
                }
            }
        }
    }
}
