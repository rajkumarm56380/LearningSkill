//
//  CartViewModel.swift
//  DemoOffLineDBApp
//
//

import Combine
import Foundation

@MainActor
final class ProductListViewModel: ObservableObject {

    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repo: ProductRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    init(repo: ProductRepositoryProtocol) {
        self.repo = repo
    }

    func load() {
        repo.fetch()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        self.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] data in
                    self?.recipes = data
                })
            .store(in: &cancellables)
    }

    func loadFoodRecipes() {
        isLoading = true

        // Simulating API / JSON parsing
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.recipes = self.mockData()
            self.isLoading = false
        }
    }

    private func mockData() -> [Recipe] {
        return [
            Recipe(
                id: 1,
                name: "Classic Margherita Pizza",
                ingredients: [],
                instructions: [],
                prepTimeMinutes: 20,
                cookTimeMinutes: 15,
                servings: 4,
                difficulty: "Easy",
                cuisine: "Italian",
                caloriesPerServing: 300,
                tags: ["Pizza"],
                userId: 166,
                image: "https://cdn.dummyjson.com/recipe-images/1.webp",
                rating: 4.6,
                reviewCount: 98,
                mealType: ["Dinner"]
            )
        ]
    }
}
