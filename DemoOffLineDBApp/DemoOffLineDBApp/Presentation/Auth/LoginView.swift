//
//  LoginView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var session: SessionManager

       var body: some View {
           VStack {
               VStack {
                   TextField("Email", text: $viewModel.email)
                       .customStyle()
                       .textFieldStyle(.roundedBorder)
                   SecureField("Password", text: $viewModel.password)
                       .customStyle()
                       .textFieldStyle(.roundedBorder)
               }.padding()
               /*Button("Login") {
                   viewModel.login()
               }.buttonStyle(.borderedProminent)

               Button("Sign Up") {
                   router.push(.signup)
               }.buttonStyle(.borderedProminent)*/

               Button(action: {
                   print("Log In")
                   viewModel.login()
               }) {
                   Text("Log In")
                    .applyButtonStyle()
               }

               Button(action: {
                   print("Sign In")
                   router.push(.signup)
               }) {
                   Text("Sign Up")
                    .applyButtonStyle()
               }

               if viewModel.isLoading {
                   ProgressView()
               }

               if viewModel.loggedUser?.isLoggedIn ?? false {
                   Text("Signup Successful")
                       .foregroundColor(.green)
               }

               if let error = viewModel.errorMessage {
                   Text(error)
                       .foregroundColor(.red)
                       .textInputAutocapitalization(.never)
                       .textCase(.lowercase)
               }

           }.navigationBarBackButtonHidden(true)
            .appNavigationStyle()
            .onChange(of: viewModel.loggedUser) {
                if let user = viewModel.loggedUser {
                    router.push(.productList)
                }
            }
           .padding()
       }
}
