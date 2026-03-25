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
    private let api = CartAPIService()
    private let db = SwiftDataStack()
    private let network = NetworkMonitor()

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
    lazy var local = CartLocalDataSource(context: db.context)
    lazy var sync = SyncManager(network: network, api: api, local: local)
    lazy var productRepo = ProductRepositoryImpl(sync: sync)

    // MARK: - ViewModels
    func makeCartVM() -> ProductListViewModel {
        ProductListViewModel(repo: productRepo)
    }

    func makeAuthVM() -> AuthViewModel {
        AuthViewModel(
            repo: authRepository,
            session: session,
            router: router
        )
    }
}

/*
final class AppDIContainer {

    lazy var apiClient = APIClient()
    lazy var swiftDataStack = SwiftDataStack()
    lazy var authService = AuthService()

    // Repositories
    lazy var cartRepository: CartRepository =
        CartRepositoryImpl(api: apiClient,
                           local: swiftDataStack)

    lazy var authRepository: AuthRepository =
        AuthRepositoryImpl(authService: authService)

    // UseCases
    lazy var fetchCartsUseCase = FetchCartsUseCase(repo: cartRepository)
    lazy var crudCartUseCase = CRUDCartUseCase(repo: cartRepository)
    lazy var authUseCase = AuthUseCase(repo: authRepository)
}


@MainActor
final class DependencyContainer {

    // MARK: Shared Services
    static let sessionManager = SessionManager()

    // MARK: - Storage
    static var storage = UserStorage()

    // MARK: - Repository
    private static let authRepository = AuthRepository(storage: storage)

    // MARK: - UseCases
    static func makeLoginUseCase() -> LoginUseCase {
        LoginUseCase(repo: authRepository)
    }

    static func makeSignupUseCase() -> SignupUseCase {
        SignupUseCase(repo: authRepository)
    }

    // MARK: - ViewModels

    static func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(
            loginUseCase: makeLoginUseCase(),
            sessionManager: sessionManager
        )
    }

    static func makeSignupViewModel() -> SignupViewModel {
        SignupViewModel(
            signupUseCase: makeSignupUseCase(),
            sessionManager: sessionManager
        )
    }

    static func makeHomeViewModel(user: User?) -> HomeViewModel {
        HomeViewModel(user: user)
    }

}
*/
