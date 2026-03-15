//
//  UserStorage.swift
//  LocationApp
//
//  Created by Apple on 15/03/26.
//

import Foundation
protocol UserStorageProtocol {
    func saveUser(_ user: User)
    func fetchUsers() -> [User]
}

final class UserStorage: UserStorageProtocol {

    private let key = "users"

    func saveUser(_ user: User) {
        var users = fetchUsers()
        users.append(user)

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
}
