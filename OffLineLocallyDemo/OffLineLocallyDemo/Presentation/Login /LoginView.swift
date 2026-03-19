//
//  LoginView.swift
//  LocationApp
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

            TextField("Email", text: $viewModel.email)
                .customStyle()

            SecureField("Password", text: $viewModel.password)
                .customStyle()

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .textInputAutocapitalization(.never)
                    .textCase(.lowercase)
            }

            Button("Login") {
                viewModel.login()
            }.buttonStyle(.borderedProminent)

            Button("Sign Up") {
                showSignup = true
                router.push(.signup)
            }.buttonStyle(.borderedProminent)

            if viewModel.isLoading {
                ProgressView()
            }

        }.padding()
            .navigationTitle("Login")
            .navigationBarBackButtonHidden(true)
            .appNavigationStyle()

            .onChange(of: viewModel.loggedUser) {
                if let user = viewModel.loggedUser {
                    router.popToRoot()
                    session.login(user: user)
                }
            }
    }
}

