//
//  HomeViewModel.swift
//  OffLineLocallyDemo
//
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var user: User?
    @Published var welcomeMessage: String = ""

    private let session: SessionManager

    init(session: SessionManager) {
        self.session =  session
        setupWelcome()
    }

    private func setupWelcome() {

        guard let user = session.currentUser else {
            welcomeMessage = "Welcome Guest"
            return
        }
        self.user = user
        welcomeMessage = "Welcome \(user.name)"
    }

    func logout() {
        user?.isLoggedIn = false
        user = nil
        welcomeMessage = "Welcome Guest"
    }
}
