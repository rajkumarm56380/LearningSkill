//
//  SignupView.swift
//  LocationApp
//
//

import SwiftUI

struct SignupView: View {

    @StateObject var viewModel: SignupViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("Create Account")
                    .font(.largeTitle)
                
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                
                Button("Sign Up") {
                    viewModel.signup()
                }
                .buttonStyle(.borderedProminent)
                
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
        }
        .navigationDestination(isPresented: $viewModel.signupSuccess) {
            HomeView(
                viewModel: DependencyContainer
                    .makeHomeViewModel(user: viewModel.loggedUser)
            )
        }.navigationTitle("SignUp Screen")
        .navigationBarBackButtonHidden(true)
        .padding()
    }
}

#Preview {
    SignupView(viewModel:  DependencyContainer.makeSignupViewModel())
}
