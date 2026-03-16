//
//  VenueRepository.swift
//  VenuesApp
//
//

import Combine

protocol VenueRepositoryProtocol {
    func getNearByVenues() -> AnyPublisher<Venue, Error>
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

    func getNearByVenues() -> AnyPublisher<Venue, Error> {
        if networkMonitor.isConnected {
            return api.fetchVenues()
                .handleEvents(receiveOutput: { [weak self] venues in
                    print("api.fetchVenues ===> \(venues.localResults.count)")
                    self?.cache.save(venues)
                }, receiveCompletion: { _ in
                    print("in completion handler")
                }, receiveCancel: {
                    print("received cancel")
                })
                .catch { [weak self] _ in
                    guard let cached = self?.cache.load() else {
                        return Empty<Venue, Never>(completeImmediately: true).eraseToAnyPublisher()
                    }
                    return Just(cached)
                        .eraseToAnyPublisher()
                }
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {

            guard let cached = cache.load() else {
                return Empty<Venue, Never>(completeImmediately: true)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
