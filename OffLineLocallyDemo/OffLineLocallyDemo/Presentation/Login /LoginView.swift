//
//  LoginView.swift
//  OffLineLocallyDemo
//
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    @State private var showSignup = false
    @EnvironmentObject var router: Router
    @EnvironmentObject var session: SessionManager

    var body: some View {

        VStack(spacing: 20) {

            Text("Welcome!")
                .font(.largeTitle.bold())

            Text("Sign in to your account")
                .font(.title3)

            AuthTextFieldView(title: "Name", text: $viewModel.email)

            AuthTextFieldView(title: "Password",
                              text: $viewModel.password,
                              isSecure: true)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .textInputAutocapitalization(.never)
                    .textCase(.lowercase)
            }

            PrimaryButtonView(
                title: "Log In",
                action: viewModel.login
            )

            // Signup Button
            HStack {
                Text("Don't have an account?")
                Button("Sign up") {
                    showSignup = true
                    router.push(.signup)
                }
                .foregroundColor(.blue)
                .fontWeight(.semibold)
            }
            .padding(.top, 10)
            Spacer()

            if viewModel.isLoading {
                ProgressView()
            }

        }.padding()
            .navigationBarBackButtonHidden(true)
            .onChange(of: viewModel.loggedUser) {
                if let user = viewModel.loggedUser {
                    router.popToRoot()
                    session.login(user: user)
                }
            }
    }
}

