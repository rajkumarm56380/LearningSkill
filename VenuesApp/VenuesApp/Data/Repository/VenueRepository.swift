//
//  VenueRepository.swift
//  VenuesApp
//
//  Created by Apple on 14/03/26.
//

import Combine

protocol VenueRepositoryProtocol {
    func getNearByVenues() -> AnyPublisher<[Venue], Never>
}

final class VenueRepository: VenueRepositoryProtocol {

    private let api: VenueAPIServiceProtocol
    private let cache: VenueCacheServiceProtocol
    private let networkMonitor: NetworkMonitor

    init(api: VenueAPIServiceProtocol, cache: VenueCacheServiceProtocol, networkMonitor: NetworkMonitor) {
        self.api = api
        self.cache = cache
        self.networkMonitor = networkMonitor
    }

    func getNearByVenues() -> AnyPublisher<[Venue], Never> {
        if networkMonitor.isConnected {
            return api.fetchVenues()
                .handleEvents(receiveOutput: { [weak self] venues in
                    print("api.fetchVenues ===> \(venues)")
                    self?.cache.save(venues)
                }, receiveCompletion: { _ in
                         print("in completion handler")
                }, receiveCancel: {
                         print("received cancel")
                })
                .catch{ _ in
                    Just(MockVenueService.venues())
                }.eraseToAnyPublisher()
        } else {
            let cached = cache.load()
            print("cached ===> \(cached)")
            if cached.isEmpty {
                return Just(self.cache.load())
                    .eraseToAnyPublisher()
            }
            return Just(cached)
                .eraseToAnyPublisher()
        }
    }
}
