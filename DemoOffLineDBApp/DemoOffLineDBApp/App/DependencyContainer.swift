//
//  DependencyContainer.swift
//  DemoOffLineDBApp
//
//

import Foundation

@MainActor
final class DependencyContainer: ObservableObject {

    // MARK: - Core
    private let api = FoodListsAPIService()
    private let db = SwiftDataStack()
    private let network = NetworkMonitor.shared

    // MARK: - Router
    let router = AppRouter()

    // MARK: - Services
    lazy var authService: AuthServiceProtocol = FirebaseAuthService()
    lazy var authRepository = AuthRepository(
        remote: authService,
        local: LocalAuthDataSource(context: db.context),
        network: network
    )

    // Proper session initialization
    lazy var session: SessionManager = {
        SessionManager(repo: authRepository, service: authService)
    }()

    // MARK: - Data Layer
    lazy var local = FoodRecipeLocalDataSource(context: db.context)
    lazy var sync = SyncManager(network: network, api: api, local: local)
    lazy var foodListsRepo = FoodListsRepositoryImpl(sync: sync)

    // MARK: - Data Layer
    lazy var authUseCase = AuthUseCase(repo: authRepository)
    lazy var foodListsUseCase = FoodListsUseCase(repo: foodListsRepo)

    // MARK: - ViewModels
    //private let repo: FoodListsRepositoryImpl =
    lazy var foodListsVM = FoodListsViewModel(repo: foodListsUseCase)

    func makeFoodListsVM() -> FoodListsViewModel {
        return foodListsVM
    }

    func makeAuthVM() -> AuthViewModel {
        AuthViewModel(
            repo: authUseCase,
            session: session,
            router: router
        )
    }
}
