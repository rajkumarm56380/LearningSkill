//
//  ItemUseCase.swift
//  DBDemo
//
//
//

import Foundation

final class ItemUseCase {
    private let repo: ItemRepositoryProtocol

    init(repo: ItemRepositoryProtocol) {
        self.repo = repo
    }

    func getItems() -> [ItemModel] {
        repo.fetchItems()
    }

    func add(title: String) {
        repo.addItem(ItemModel(id: UUID(), title: title))
    }

    func update(item: ItemModel) {
        repo.updateItem(item)
    }

    func delete(id: UUID) {
        repo.deleteItem(id)
    }

    func deleteAll() {
        repo.deleteAll()
    }
}
