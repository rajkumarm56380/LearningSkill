//
//  LocalUser.swift
//  DemoOffLineDBApp
//
//

import SwiftData

@Model
final class LocalUser {
    @Attribute(.unique) var id: String
    var email: String
    var isLoggedIn: Bool

    init(id: String, email: String, isLoggedIn: Bool) {
        self.id = id
        self.email = email
        self.isLoggedIn = isLoggedIn
    }
}
