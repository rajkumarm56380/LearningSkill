//
//  SignupView.swift
//  DemoCombine
//
//  Created by Apple on 02/03/26.
//

import SwiftUI

struct SignupView: View {

    @StateObject var viewModel: SignupViewModel

    var body: some View {
        VStack(spacing: 16) {

            TextField("Name", text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
                .accessibilityIdentifier("signup_name")

            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .accessibilityIdentifier("signup_email")

            SecureField("Password", text: $viewModel.password)
                .accessibilityIdentifier("signup_password")

            Button("Signup") {
                viewModel.signup()
            }
            .accessibilityIdentifier("signup_button")

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            NavigationLink(
                destination: LoginView(
                    viewModel: DIContainer.shared.makeLoginVM()
                ),
                isActive: $viewModel.isSignedUp
            ) {
                EmptyView()
            }
        }
        .padding()
        .navigationTitle("Signup")
    }
}

#Preview {
    NavigationStack {
        SignupView(viewModel: DIContainer.shared.makeSignupVM())
    }
}
