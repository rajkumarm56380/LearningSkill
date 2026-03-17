//
//  LoginUseCaseProtocol.swift
//  DBDemo
//
//
//

import Combine
import Foundation

protocol ItemRepositoryProtocol {
    func fetchItems() -> [ItemModel]
    func addItem(_ item: ItemModel)
    func updateItem(_ item: ItemModel)
    func deleteItem(_ id: UUID)
    func deleteAll()
}
