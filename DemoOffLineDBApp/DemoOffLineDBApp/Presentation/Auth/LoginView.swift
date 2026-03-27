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

                Image("FoodLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)

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
                    action: viewModel.login
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
        .navigationBarBackButtonHidden(true)

        .padding(.vertical)

        }.loading(viewModel.isLoading)
        .toast(message: $viewModel.errorMessage)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
