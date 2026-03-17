//
//  DependencyContainer.swift
//  VenuesApp
//
//

import SwiftUI
final class DependencyContainer {
    
    static let shared = DependencyContainer()

    private let networkMonitor = NetworkMonitor()

    func makeVenueListViewModel() -> VenueListViewModel {
        let apiService = VenueAPIService()
        let cacheService = VenueCacheService()
        let mockService = MockVenueService()
        let networkMonitor = NetworkMonitor()

        let repository = VenueRepository(
            apiService: apiService,
            cacheService: cacheService,
            networkMonitor: networkMonitor,
            mockService: mockService,
        )

        let useCase = GetNearbyVenuesUseCase(repository: repository)

        return VenueListViewModel(useCase: useCase)
    }

}
