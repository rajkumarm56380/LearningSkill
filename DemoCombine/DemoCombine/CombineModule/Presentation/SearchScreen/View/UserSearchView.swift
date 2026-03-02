//
//  UserSearchView.swift
//  DemoCombine
//
//  Created by user on 02/03/26.
//
import SwiftUI

struct UserSearchView: View {

    @StateObject private var viewModel: UserSearchViewModel

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search users...", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                if viewModel.isLoading {
                    ProgressView()
                }

                List(viewModel.users) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Reactive Search")
        }
    }
}

