//
//  LocalUser.swift
//  DemoOffLineDBApp
//
//

import SwiftData

@Model
final class LocalUser {
    @Attribute(.unique) var id: String
    var name: String
    var email: String
    var isLoggedIn: Bool

    init(id: String, name:String, email: String, isLoggedIn: Bool) {
        self.id = id
        self.name = name
        self.email = email
        self.isLoggedIn = isLoggedIn
    }
}
