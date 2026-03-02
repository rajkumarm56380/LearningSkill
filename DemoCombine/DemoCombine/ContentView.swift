//
//  ContentView.swift
//  DemoCombine
//
//  Created by user on 25/02/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var networkManager = NetworkManager()

        var body: some View {
            VStack {
                if networkManager.isLoading {
                    ProgressView()
                } else if let user = networkManager.user {
                    Text("User: \(user.name)")
                } else {
                    Text("No user data.")
                }

                Button("Fetch User") {
                    networkManager.fetchUser()
                }
            }
            .padding()
        }

}

#Preview {
    ContentView()
}
