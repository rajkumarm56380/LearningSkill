//
//  ItemRepository.swift
//  DBDemo
//
//
//

import Foundation

final class ItemRepository: ItemRepositoryProtocol {
    private let stack: SwiftDataStack
    init(stack: SwiftDataStack) { self.stack = stack }

    func fetchItems() -> [ItemModel] {
        stack.fetch(ItemEntity.self).map { ItemModel(id: $0.id,title: $0.title) }
    }

    func addItem(_ item: ItemModel) {
        stack.insert(ItemEntity(id: item.id, title: item.title, createdAt: item.title))
    }

    func deleteItem(_ id: UUID) {
        let items = stack.fetch(ItemEntity.self)
        items.filter { $0.id == id }.forEach { stack.delete($0) }
    }

    func updateItem(_ item: ItemModel) {

    }
    func deleteAll() {
        stack.deleteAll(ItemEntity.self)
    }
}
