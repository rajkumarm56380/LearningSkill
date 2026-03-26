//
//  LocalAuthDataSource.swift
//  DemoOffLineDBApp
//
//

import SwiftData
import Foundation

final class LocalAuthDataSource {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func saveUser(_ user: User) {
        let local = LocalUser(
            id: user.id.uuidString,
            name:user.name,
            email: user.email,
            isLoggedIn: true
        )
        context.insert(local)
        try? context.save()
    }

    func fetchLoggedInUser() -> LocalUser? {
        let descriptor = FetchDescriptor<LocalUser>(
            predicate: #Predicate { $0.isLoggedIn == true }
        )
        return try? context.fetch(descriptor).first
    }

    func logout() {
        let users = try? context.fetch(FetchDescriptor<LocalUser>())
        users?.forEach { $0.isLoggedIn = false }
        try? context.save()
    }
}
