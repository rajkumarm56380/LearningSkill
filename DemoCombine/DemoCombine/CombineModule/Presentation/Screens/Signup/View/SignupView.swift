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
        }
        .padding()
        .navigationTitle("Signup")
        .navigationDestination(isPresented: $viewModel.isSignedUp) {
            LoginView(
                viewModel: DIContainer.shared.makeLoginVM()
            )
        }
    }
}

#Preview {
    NavigationStack {
        SignupView(viewModel: DIContainer.shared.makeSignupVM())
    }
}
