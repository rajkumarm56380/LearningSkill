//
//  DependencyContainer.swift
//  DemoOffLineDBApp
//
//

import Foundation
import Combine

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


    // MARK: - ViewModels
    //private let repo: FoodListsRepositoryImpl =
    lazy var foodListsVM = FoodListsViewModel(repo: foodListsRepo)

    func makeFoodListsVM() -> FoodListsViewModel {
        foodListsVM
    }

    func makeAuthVM() -> AuthViewModel {
        AuthViewModel(
            repo: authRepository,
            session: session,
            router: router
        )
    }
}
