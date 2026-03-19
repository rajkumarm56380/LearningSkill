//
//  RootView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var router: Router

    var body: some View {

        NavigationStack(path: $router.path) {

            Group {
                if session.isLoggedIn {
                    HomeView(
                        viewModel: DependencyContainer
                            .makeHomeViewModel(user: session.currentUser)
                    )
                } else {
                    LoginView(
                        viewModel: DependencyContainer.makeLoginViewModel()
                    )
                }
            }
            .toolbar(.visible, for: .navigationBar)
            //  REQUIRED for Router navigation
            .navigationDestination(for: AppRoute.self) { route in

                switch route {

                case .signup:
                    SignupView(
                        viewModel: DependencyContainer.makeSignupViewModel()
                    )

                case .home(let user):
                    HomeView(
                        viewModel: DependencyContainer.makeHomeViewModel(user: user)
                    )
                }
            }
        }
    }
}
#Preview {
    RootView()
}
