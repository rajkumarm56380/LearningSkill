//
//  UserEntity.swift
//  DBDemo
//
//
//

import SwiftData
import Foundation

@Model
class UserEntity {
    @Attribute(.unique) var id: UUID
    var email: String
    var password: String
    
    init(id: UUID = UUID(), email: String, password: String) {
        self.id = id
        self.email = email
        self.password = password
    }
}
