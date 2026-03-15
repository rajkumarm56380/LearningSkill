//
//  LoginView.swift
//  LocationApp
//
//  Created by Apple on 15/03/26.
//

import SwiftUI

struct LoginView: View {

    @StateObject var viewModel: LoginViewModel

    var body: some View {

        VStack(spacing: 20) {

            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)

            Button("Login") {
                viewModel.login()
            }

            if viewModel.isLoading {
                ProgressView()
            }

            if viewModel.isLoggedIn {
                Text("Login Successful")
            }

        }
        .padding()
    }
}

//#Preview {
//    LoginView(viewModel: <#LoginViewModel#>)
//}
