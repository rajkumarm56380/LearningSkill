//
//  LoginView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var session: SessionManager

    var body: some View {
        ZStack {
            VStack(spacing: 20) {

                Spacer()

                Text("Welcome!")
                    .font(.largeTitle.bold())

                Text("Sign in to your account")
                    .font(.title3)

                AuthTextFieldView(title: "Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                AuthTextFieldView(title: "Password",
                                  text: $viewModel.password,
                                  isSecure: true)

                //ErrorTextView(message: viewModel.errorMessage)

                PrimaryButtonView(
                    title: "Log In",
                    action: viewModel.login,
                    isLoading: viewModel.isLoading
                )

                HStack {
                    Text("Don't have an account?")
                    Button("Sign up") {
                        router.push(.signup)
                    }
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                }
                .padding(.top, 10)

                Spacer()
            }

        .loading(viewModel.isLoading)
        .padding(.vertical)
        .toast(message: $viewModel.errorMessage)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        }
    }
}
