//
//  AuthState.swift
//  OffLineLocallyDemo
//
//

import SwiftUI
import Combine

final class SessionManager: ObservableObject {

    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?

    private let loginKey = "isLoggedIn"

    init() {
        checkLoginStatus()
    }

    // Check login when app launches
    func checkLoginStatus() {

        let loggedIn = UserDefaults.standard.bool(forKey: loginKey)
        self.isLoggedIn = loggedIn

        if loggedIn {
            loadUser()
        }
    }

    func login(user: User) {

        currentUser = user
        isLoggedIn = true

        UserDefaults.standard.set(true, forKey: loginKey)
    }

    func logout() {

        currentUser = nil
        isLoggedIn = false

        UserDefaults.standard.set(false, forKey: loginKey)
    }

    private func loadUser() {
        
        guard let data = UserDefaults.standard.data(forKey: "users"),
              let users = try? JSONDecoder().decode([User].self, from: data)
        else { return }
        
        currentUser = users.first
    }

}
