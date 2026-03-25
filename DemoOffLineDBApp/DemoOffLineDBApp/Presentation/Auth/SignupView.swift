//
//  SignupView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct SignupView: View {

    @StateObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var router: AppRouter

    var body: some View {
        VStack(spacing: 20) {

            TextField("Name", text: $viewModel.name)
                .customStyle()

            TextField("Email", text: $viewModel.email)
                .customStyle()

            SecureField("Password", text: $viewModel.password)
                .customStyle()

            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .customStyle()

            Button(action: {
                print("Log In")
                router.pop()
            }) {
                Text("Log In")
                    .applyButtonStyle()
            }

            // Signup Button
            Button(action: {
                print("Sign Up")
                viewModel.signup()
            }) {
                Text("Sign Up")
                    .applyButtonStyle()
            }

            if viewModel.isLoading {
                ProgressView()
            }

            if viewModel.signupSuccess {
                Text("Signup Successful")
                    .foregroundColor(.green)
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

        }
        .padding()
        .navigationTitle("SignUp Screen")
        .navigationBarBackButtonHidden(true)
        .appNavigationStyle()
        .onChange(of: viewModel.signupSuccess) {
            if viewModel.signupSuccess {
                router.pop()
            }
        }
    }
}

