//
//  SyncManager.swift
//  DemoOffLineDBApp
//
//

import Combine
import Foundation

final class SyncManager: SyncManagerProtocol {

    private let network: NetworkMonitorProtocol
    private let api: APIClientProtocol
    private let local: FoodRecipeLocalDataSourceProtocol

    init(network: NetworkMonitorProtocol,
         api: APIClientProtocol,
         local: FoodRecipeLocalDataSourceProtocol) {
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
        return api.request(Endpoint.recipes.url)
        //  Save API response to local DB
            .handleEvents(receiveOutput: { [weak self] dtos in
                self?.saveLocal(dtos)
            })
        //   Map DTO → Domain
        .map(FoodProductMapper.mapDTOArrayToDomain)

        // CRITICAL: fallback to local if API fails
            .catch { [weak self] error -> AnyPublisher<[Recipe], APIError> in
                guard let self = self else {
                    return Fail(error: .unknown).eraseToAnyPublisher()
                }

                let localData = self.local.fetch()

                guard !localData.isEmpty else {
                    return Fail(error: error).eraseToAnyPublisher()
                }

                return Just(self.local.fetch())
                    .setFailureType(to: APIError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    //  actor-isolated — only called via Task { await }
    private func saveLocal(_ dtos: [FoodRecipeDTO]) {
        local.save(dtos)
    }
}
