//
//  User.swift
//  DemoOffLineDBApp
//
//  Created by Apple on 19/03/26.
//

import Foundation

import Foundation
struct User: Codable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let email: String
    let password: String
    var isLoggedIn: Bool = false
}
