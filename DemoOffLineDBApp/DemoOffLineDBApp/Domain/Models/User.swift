//
//  User.swift
//  DemoOffLineDBApp
//
//

import Foundation
struct User: Codable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let email: String
    let password: String
    var isLoggedIn: Bool = false
}
