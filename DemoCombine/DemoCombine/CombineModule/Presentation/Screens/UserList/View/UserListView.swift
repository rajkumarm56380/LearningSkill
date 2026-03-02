//
//  UserListView.swift
//  DemoCombine
//
//  Created by Apple on 02/03/26.
//

import SwiftUI

import SwiftUI

struct UserListView: View {

    @StateObject var viewModel: UserListViewModel

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List(viewModel.users) { user in
                    NavigationLink(
                        destination: UserDetailView(user: user)
                    ) {
                        Text(user.name)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchUsers()
        }
        .alert(
            "Error",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )
        ) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}

#Preview {
    UserListView(viewModel: DIContainer.shared.makeUserListVM())
}
