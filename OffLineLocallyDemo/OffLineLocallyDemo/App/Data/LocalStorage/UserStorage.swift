//
//  UserStorage.swift
//  LocationApp
//

import Foundation
protocol UserStorageProtocol {
    func saveUser(_ user: User)
    func fetchUsers(email: String) -> [User]
}

final class UserStorage: UserStorageProtocol {

    private let key = "users"

    func saveUser(_ user: User) {
        var users = fetchUsers(email: user.email)
        if let index = users.firstIndex(of: user) {
            users[index] = user
        }
        users.append(user)

        let data = try? JSONEncoder().encode(users)
        UserDefaults.standard.set(data, forKey: key)
    }

    func fetchUsers(email: String) -> [User] {

        guard let data = UserDefaults.standard.data(forKey: key),
              let users = try? JSONDecoder().decode([User].self, from: data)
        else {
            return []
        }
        return users
    }

    func isLoggedUser() -> Bool {
        return fetchUsers(email: "").isEmpty ? false : true
    }
}
