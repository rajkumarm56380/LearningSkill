//
//  RootView.swift
//  OffLineLocallyDemo
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
                    HomeView(
                        viewModel: container.makeHomeViewModel()
                    )
                } else {
                    LoginView(
                        viewModel: container.makeLoginVM()
                    )
                }
            }
            .toolbar(.visible, for: .navigationBar)
            //  REQUIRED for Router navigation
            .navigationDestination(for: Route.self) { route in

                switch route {

                case .signup:
                    SignupView(
                        viewModel: container.makeSignupVM()
                    )

                case .home(let user):
                    HomeView(
                        viewModel: container.makeHomeViewModel()
                    )
                }
            }
        }
    }
}
#Preview {
    RootView(container: DependencyContainer())
}
