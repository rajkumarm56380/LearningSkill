//
//  HomeViewModel.swift
//  LocationApp
//
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var user: User?
    @Published var welcomeMessage: String = ""

    init(user: User?) {
        self.user = user
        setupWelcome()
    }

    private func setupWelcome() {

        guard let user = user else {
            welcomeMessage = "Welcome Guest"
            return
        }

        welcomeMessage = "Welcome \(user.name)"
    }

    func logout() {
        user?.isLoggedIn = false
        if let user = user {
            DependencyContainer.storage.saveUser(user)
        }
        user = nil
        welcomeMessage = "Welcome Guest"
    }
}
