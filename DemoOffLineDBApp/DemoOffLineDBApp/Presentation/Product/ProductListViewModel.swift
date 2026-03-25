//
//  CartViewModel.swift
//  DemoOffLineDBApp
//
//

import Combine
import Foundation

final class ProductListViewModel: ObservableObject {

    @Published var products: [Product] = []

    private let repo: ProductRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    init(repo: ProductRepositoryProtocol) {
        self.repo = repo
    }

    func load() {
        repo.fetch()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] in
                self?.products = $0
            })
            .store(in: &cancellables)
    }
}
