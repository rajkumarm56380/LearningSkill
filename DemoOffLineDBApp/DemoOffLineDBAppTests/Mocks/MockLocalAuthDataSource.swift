//
//  MockLocalAuthDataSource.swift
//  DemoOffLineDBAppTests
//
//

import Foundation

final class MockLocalAuthDataSource: LocalAuthDataSourceProtocol {

    var storedUser: LocalUser?
    var saveCalled = false
    var logoutCalled = false

    func saveUser(_ user: User) {
        saveCalled = true
        storedUser = LocalUser(
            id: user.id.uuidString,
            name: user.name,
            email: user.email,
            isLoggedIn: true
        )
    }

    func fetchLoggedInUser() -> LocalUser? {
        storedUser
    }

    func logout() {
        logoutCalled = true
        storedUser?.isLoggedIn = false
        storedUser = nil
    }
}
