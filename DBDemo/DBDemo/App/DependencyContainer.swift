//
//  DependencyContainer.swift
//  DBDemo
//
//
//

import Foundation

final class DependencyContainer {

    static let shared = DependencyContainer()

    // MARK: - Data Sources
    private let swiftDataStack = SwiftDataStack.shared

    // MARK: - Repositories
    lazy var authRepository: AuthRepositoryProtocol = AuthRepository(stack: swiftDataStack)
    lazy var itemRepository: ItemRepositoryProtocol = ItemRepository(stack: swiftDataStack)

    // MARK: - UseCases
    lazy var loginUseCase = LoginUseCase(repo: authRepository)
    lazy var signupUseCase = SignupUseCase(repo: authRepository)
    lazy var itemUseCase = ItemUseCase(repo: itemRepository)
    
}
