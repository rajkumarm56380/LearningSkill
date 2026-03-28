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

    private let repo: FoodListsUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    private var hasLoaded = false

    init(repo: FoodListsUseCaseProtocol) {
        self.repo = repo
    }

    func load() {

        guard !hasLoaded else { return }
           hasLoaded = true

        guard !isLoading else { return }

        isLoading = true

        repo.execute()
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)     
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] data in
                self?.recipes = data
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
