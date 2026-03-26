//
//  SignupView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct SignupView: View {

    @StateObject var viewModel: AuthViewModel
    @EnvironmentObject var router: AppRouter
    @Environment(\.dismiss) var dismiss
    
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
            }
         .padding()
         .navigationBarBackButtonHidden(true)
         .toolbar {
             ToolbarItem(placement: .navigationBarLeading) {
                 Button {
                     dismiss()
                 } label: {
                     HStack {
                         Image(systemName: "chevron.backward")
                     }
                 }
             }
         }
       }.loading(viewModel.isLoading)
        .toast(message: $viewModel.errorMessage)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

