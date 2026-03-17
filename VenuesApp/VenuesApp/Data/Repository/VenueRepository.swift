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

    private let apiService: VenueAPIServiceProtocol
    private let cacheService: VenueCacheServiceProtocol
    private let networkMonitor: NetworkMonitor
    private let mockService: MockVenueService

    init(apiService: VenueAPIServiceProtocol,
         cacheService: VenueCacheServiceProtocol,
         networkMonitor: NetworkMonitor,
         mockService: MockVenueService) {
        self.apiService = apiService
        self.cacheService = cacheService
        self.networkMonitor = networkMonitor
        self.mockService = mockService
    }

    func getNearByVenues() -> AnyPublisher<Venue, Error> {
        if networkMonitor.isConnected {
            return apiService.fetchVenues()
                .handleEvents(receiveOutput: { [weak self] venues in
                    print("api.fetchVenues ===> \(venues.localResults.count)")
                    self?.cacheService.save(venues)
                }, receiveCompletion: { _ in
                    print("in completion handler")
                }, receiveCancel: {
                    print("received cancel")
                })
                .catch { [weak self] _ in
                    guard let cached = self?.cacheService.load() else {
                        return Empty<Venue, Never>(completeImmediately: true).eraseToAnyPublisher()
                    }
                    return Just(cached)
                        .eraseToAnyPublisher()
                }
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {

            guard let cached = cacheService.load() else {
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
