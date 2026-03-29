//
//  SignupView.swift
//  OffLineLocallyDemo
//
//

import SwiftUI
import SharedUIKits

struct SignupView: View {

    @StateObject var viewModel: SignupViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var router: AppRouter

    var body: some View {
        ZStack{
            LazyVStack(spacing: 20) {

                Text("Create Account")
                    .font(.largeTitle.bold())
                    .padding(.top)

                AuthTextFieldView(title: "Name", text: $viewModel.name)

                AuthTextFieldView(title: "Email", text: $viewModel.email)

                AuthTextFieldView(title: "Password",
                                  text: $viewModel.password,
                                  isSecure: true)

                AuthTextFieldView(title: "Confirm Password",
                                  text: $viewModel.confirmPassword,
                                  isSecure: true)

                PrimaryButtonView(
                    title: "Sign Up",
                    action: viewModel.signup
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

                if viewModel.signupSuccess {
                    Text("Signup Successful")
                        .foregroundColor(.green)
                }

                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .padding()
            .onChange(of: viewModel.signupSuccess) {
                if viewModel.signupSuccess {
                    router.pop()
                }
            }
            .toast(message: $viewModel.errorMessage)
            .loading(viewModel.isLoading)
    }
}

