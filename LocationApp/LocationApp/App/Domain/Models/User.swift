//
//  User.swift
//  LocationApp
//
//  Created by Apple on 15/03/26.
//

import Foundation
struct User: Codable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let email: String
    let password: String
}
