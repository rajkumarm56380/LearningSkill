//
//  SwiftDataStack.swift
//  DBDemo
//
//
//

import SwiftData

final class SwiftDataStack {
    static let shared = SwiftDataStack()
    let container: ModelContainer
    let context: ModelContext

    private init() {
        container = try! ModelContainer(for: UserEntity.self, ItemEntity.self)
        context = ModelContext(container)
    }

    func insert<T>(_ object: T) where T: PersistentModel {
        context.insert(object)
        try? context.save()
    }

    func fetch<T>(_ type: T.Type) -> [T] where T: PersistentModel {
        return (try? context.fetch(FetchDescriptor<T>())) ?? []
    }

    func delete<T>(_ object: T) where T: PersistentModel {
        context.delete(object)
        try? context.save()
    }

    func deleteAll<T>(_ type: T.Type) where T: PersistentModel {
        let items = fetch(type)
        items.forEach { context.delete($0) }
        try? context.save()
    }
}
