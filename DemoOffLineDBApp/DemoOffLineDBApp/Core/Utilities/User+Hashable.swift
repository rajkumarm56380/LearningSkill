//
//  User+Hashable.swift
//  DemoOffLineDBApp
//
//

import Foundation

// Hashable conformance for User so it can be used in Hashable enums like AppRoute
extension User: Hashable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

