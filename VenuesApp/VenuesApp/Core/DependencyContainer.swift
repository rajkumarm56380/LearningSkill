//
//  DependencyContainer.swift
//  VenuesApp
//
//  Created by Apple on 14/03/26.
//

import SwiftUI
final class DependencyContainer {
    
    static func makeVenueListView() -> some View {
        let api = VenueAPIService()
        let cache = VenueCacheService()
        let monitor = NetworkMonitor.shared
        let repository = VenueRepository(api: api, cache: cache, networkMonitor: monitor)
        let useCase = GetNearbyVenuesUseCase(repository: repository)
        let viewModel = VenueListViewModel(useCase: useCase)
        return VenueListView(viewModel: viewModel)
    }

}
