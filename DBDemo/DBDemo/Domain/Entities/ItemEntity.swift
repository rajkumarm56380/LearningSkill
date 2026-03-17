//
//  ItemEntity.swift
//  DBDemo
//
//
//

import SwiftData
import Foundation

@Model
class ItemEntity {
    @Attribute(.unique) var id: UUID
    var title: String
    var createdAt: String

    init(id: UUID = UUID(), title: String, createdAt: String) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
    }
}
