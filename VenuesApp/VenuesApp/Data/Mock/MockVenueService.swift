//
//  MockVenueService.swift
//  VenuesApp
//
//

import Foundation

final class MockVenueService {

    static func venues() -> [Venue] {
        return VenueMockData.loadVenues()
    }
}

final class VenueMockData {
    static func loadVenues() -> [Venue] {
        guard let url = Bundle.main.url(forResource: "Venue", withExtension: "json") else {
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Venue].self, from: data)
        } catch {
            // In a mock service, failing silently to an empty array is acceptable
            return []
        }
    }
}
