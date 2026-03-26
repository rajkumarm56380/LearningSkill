//
//  FoodListsViewModel.swift
//  DemoOffLineDBApp
//
//

import Combine
import Foundation

@MainActor
final class FoodListsViewModel: ObservableObject {

    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repo: FoodListsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private var hasLoaded = false

    init(repo: FoodListsRepositoryProtocol) {
        self.repo = repo
    }

    func load() {

        guard !hasLoaded else { return }
           hasLoaded = true

        guard !isLoading else { return }

        isLoading = true

        repo.fetch()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] data in
                self?.recipes = data
                self?.isLoading = false
            }
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
