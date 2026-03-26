//
//  SyncManager.swift
//  DemoOffLineDBApp
//
//

import Combine

final class SyncManager {

    private let network: NetworkMonitor
    private let api: FoodListsAPIService
    private let local: FoodRecipeLocalDataSource

    init(network: NetworkMonitor, api: FoodListsAPIService, local: FoodRecipeLocalDataSource) {
        self.network = network
        self.api = api
        self.local = local
    }

    func fetchProducts() -> AnyPublisher<[Recipe], APIError> {
        // OFFLINE → Always local
        guard network.isConnected else {
                    return Just(local.fetch())
                        .setFailureType(to: APIError.self)
                        .eraseToAnyPublisher()
                }

        // ONLINE → API + Cache + Fallback
        return api.fetchFoodRecipes()

        //  Save API response to local DB
            .handleEvents(receiveOutput: { [weak self] dtos in
                self?.local.save(dtos)
            })

        //   Map DTO → Domain
            .map(FoodProductMapper.mapDTOArrayToDomain)

        // CRITICAL: fallback to local if API fails
            .catch { [weak self] error -> AnyPublisher<[Recipe], APIError> in
                guard let self = self else {
                    return Fail(error: .unknown).eraseToAnyPublisher()
                }

                let localData = self.local.fetch()

                if !localData.isEmpty {
                    return Just(localData)
                        .setFailureType(to: APIError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: error).eraseToAnyPublisher()
                }
            }

            .eraseToAnyPublisher()
    }

    func fetchProductsNews() -> AnyPublisher<[Recipe], APIError> {

        let localPublisher = Just(local.fetch())
            .setFailureType(to: APIError.self)

        let remotePublisher = api.fetchFoodRecipes()
            .handleEvents(receiveOutput: { [weak self] in self?.local.save($0) })
            .map(FoodProductMapper.mapDTOArrayToDomain)

        return localPublisher
            .append(remotePublisher) // show local first, then refresh
            .eraseToAnyPublisher()
    }
}
