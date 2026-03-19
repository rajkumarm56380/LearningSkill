//
//  UserStorage.swift
//  LocationApp
//

import Foundation
protocol UserStorageProtocol {
    func saveUser(_ user: User)
    func fetchUsers() -> [User]
    func isUserExist(email: String) -> Bool
}

final class UserStorage: UserStorageProtocol {

    private let key = "users"

    func saveUser(_ user: User) {
        var users = fetchUsers()
        if let index = users.firstIndex(of: user) {
            users[index] = user
        } else {
            users.append(user)
        }

        let data = try? JSONEncoder().encode(users)
        UserDefaults.standard.set(data, forKey: key)
    }

    func fetchUsers() -> [User] {

        guard let data = UserDefaults.standard.data(forKey: key),
              let users = try? JSONDecoder().decode([User].self, from: data)
        else {
            return []
        }
        return users
    }

    func isUserExist(email: String) -> Bool {
        return (fetchUsers().first(where: {
            $0.email.lowercased() == email.lowercased()
        }) != nil)
    }
}
