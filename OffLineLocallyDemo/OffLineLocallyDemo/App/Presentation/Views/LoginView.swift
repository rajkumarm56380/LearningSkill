//
//  LoginView.swift
//  LocationApp
//
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel

    var body: some View {

        NavigationView {
            VStack(spacing: 20) {

                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)

                Button("Login") {
                    viewModel.login()
                }

                NavigationLink(destination: SignupView(viewModel: DependencyContainer.makeSignupViewModel())) {
                    Text("Sign Up")
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }

            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                HomeView(
                    viewModel: DependencyContainer
                        .makeHomeViewModel(user: viewModel.loggedUser)
                )
            }
        }.navigationTitle("Login Screen")
        .padding()
    }
}

#Preview {
    LoginView(viewModel: DependencyContainer.makeLoginViewModel())
}
