//
//  SignupView.swift
//  OffLineLocallyDemo
//
//

import SwiftUI

struct SignupView: View {

    @StateObject var viewModel: SignupViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var router: Router

    var body: some View {
            VStack(spacing: 20) {

                TextField("Name", text: $viewModel.name)
                    .customStyle()
                
                TextField("Email", text: $viewModel.email)
                    .customStyle()

                SecureField("Password", text: $viewModel.password)
                    .customStyle()

                Button("Sign Up") {
                    viewModel.signup()
                }
                .buttonStyle(.borderedProminent)

                Button("Login") {
                    router.pop()
                }.buttonStyle(.borderedProminent)

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
            .appNavigationStyle()
            .applyBackgroundColor()
            .onChange(of: viewModel.signupSuccess) {
                if viewModel.signupSuccess {
                    router.pop()
                }
            }
    }
}

