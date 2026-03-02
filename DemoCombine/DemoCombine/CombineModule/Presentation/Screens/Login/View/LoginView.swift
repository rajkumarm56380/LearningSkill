//
//  View.swift
//  DemoCombine
//
//  Created by Apple on 02/03/26.
//

import SwiftUI

struct LoginView: View {

    @StateObject var viewModel: LoginViewModel

    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $viewModel.password)

            Button("Login") {
                viewModel.login()
            }

            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }

            NavigationLink(
                destination: UserListView(
                    viewModel: DIContainer.shared.makeUserListVM()
                ),
                isActive: $viewModel.isLoggedIn
            ) { EmptyView() }
        }
        .padding()
    }
}
