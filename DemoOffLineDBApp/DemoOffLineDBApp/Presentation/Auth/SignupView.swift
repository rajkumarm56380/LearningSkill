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
        
        ScrollView {
            VStack(spacing: 20) {

                Text("Create Account")
                    .font(.largeTitle.bold())
                    .padding(.top)

                AuthTextFieldView(title: "Name", text: $viewModel.name)
                AuthTextFieldView(title: "Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                AuthTextFieldView(title: "Password",
                                  text: $viewModel.password,
                                  isSecure: true)
                AuthTextFieldView(title: "Confirm Password",
                                  text: $viewModel.confirmPassword,
                                  isSecure: true)

                //ErrorTextView(message: viewModel.errorMessage)

                PrimaryButtonView(
                    title: "Sign Up",
                    action: viewModel.signup,
                    isLoading: viewModel.isLoading
                )

                HStack {
                    Text("Already have an account?")
                    Button("Log in") {
                        router.pop()
                    }
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                }
                .padding(.top, 10)
            }
         .padding()
        .loading(viewModel.isLoading)
        .toast(message: $viewModel.errorMessage)
        .ignoresSafeArea(.keyboard, edges: .bottom)
       }
    }
}

