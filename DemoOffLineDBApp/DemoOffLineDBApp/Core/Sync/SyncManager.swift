//
//  SyncManager.swift
//  DemoOffLineDBApp
//
//

import Combine

final class SyncManager {

    private let network: NetworkMonitor
    private let api: CartAPIService
    private let local: CartLocalDataSource

    init(network: NetworkMonitor, api: CartAPIService, local: CartLocalDataSource) {
        self.network = network
        self.api = api
        self.local = local
    }

    func fetchProducts() -> AnyPublisher<[Product], Error> {

        if network.isConnected {
            return api.fetch()
                .handleEvents(receiveOutput: { [weak self] dtos in
                    self?.local.save(dtos)
                })
                .map(ProductMapper.mapDTOArrayToDomain)
                .eraseToAnyPublisher()

        } else {

            let localProducts = local.fetch()
            return Just(localProducts)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
