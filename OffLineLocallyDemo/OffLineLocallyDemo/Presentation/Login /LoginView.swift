//
//  LoginView.swift
//  OffLineLocallyDemo
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
            Rectangle()
                 .frame(height: 2)
                 .foregroundColor((viewModel.errorMessage ?? "").isEmpty ?
                   .red :
                   Color(red: 189 / 255, green: 204 / 255, blue: 215 / 255))
            
            SecureField("Password", text: $viewModel.password)
                .customStyle()

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .textInputAutocapitalization(.never)
                    .textCase(.lowercase)
            }

            Button(action: { print("Log In")
            }) {
                            Text("Log In")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                        // Signup Button
                        Button(action: { print("Sign Up") }) {
                            Text("Sign Up")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .cornerRadius(10)
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
            .applyBackgroundColor()
            .onChange(of: viewModel.loggedUser) {
                if let user = viewModel.loggedUser {
                    router.popToRoot()
                    session.login(user: user)
                }
            }
    }
}

