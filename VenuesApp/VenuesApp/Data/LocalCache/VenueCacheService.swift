//
//  VenueCacheService.swift
//  VenuesApp
//
//

import Foundation

protocol VenueCacheServiceProtocol {
    func save(_ venues: [Venue])
    func load() -> [Venue]
}

final class VenueCacheService: VenueCacheServiceProtocol {
    private let key = "cachedVenues"

    func save(_ venue: [Venue]) {
        let data = try? JSONEncoder().encode(venue)
        UserDefaults.standard.set(data, forKey: key)
    }

    func load() -> [Venue] {
        guard let data =  UserDefaults.standard.data(forKey: key),
              let venues = try? JSONDecoder().decode(VenueList.self, from: data) else {
            return []
        }
        return venues.venueList
    }
}

