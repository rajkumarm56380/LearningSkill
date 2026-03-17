//
//  HomeViewModel.swift
//  DBDemo
//
//
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {

    @Published var items: [ItemModel] = []
    @Published var inputText: String = ""

    private let useCase: ItemUseCase

    init(useCase: ItemUseCase) {
        self.useCase = useCase
        loadItems()
    }

    func loadItems() {
        items = useCase.getItems()
    }

    func addItem() {
        guard !inputText.isEmpty else { return }
        useCase.add(title: inputText)
        inputText = ""
        loadItems()
    }

    func deleteItem(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let item = items[index]
            useCase.delete(id: item.id)
        }
        loadItems()
    }

    func deleteAll() {
        useCase.deleteAll()
        loadItems()
    }
}
