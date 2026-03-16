//
//  MockVenueService.swift
//  VenuesApp
//
//

import Foundation

enum MockImage: String {
    case imageUrl = "https://dummyimage.com/200x200/d6d6d6/fff.png"
}

final class MockVenueService {
    static func venues() -> Venue? {
        return VenueMockData.loadVenues()
    }
    static func getVenuesList() -> [LocalResult] {
        return venues()?.localResults ?? []
    }
}

final class VenueMockData {
    static func loadVenues() -> Venue? {
        guard let url = Bundle.main.url(forResource: "Venue", withExtension: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Venue.self, from: data)
        } catch {
            // In a mock service, failing silently to an empty array is acceptable
            return nil
        }
    }
    
    static func getVenuesList() -> [LocalResult] {
        return loadVenues()?.localResults ?? []
    }

    static func getMockDataVenueTest() -> Venue {

        let localResultsVal: [LocalResult] = [
            LocalResult(position: 1, title: "Chikmagaluru Cofee (hot and cold coffee)", type:"Coffee shop", rating: 4.4, reviews: 29, price: "₹1–200", description: "Super delicious authentic coffee.", lsig: "AB86z5UbkLkm1UxOoP8qgqk-Gh4v", images: [ "https://lh3.googleusercontent.com/gps-cs-s/AHVAwercLwd70sGUTDZFxHUExj0IQfwsBkn7kqN9XVVoouF1oXW6_pvGgBUSlmIIRrk6bPot7reohHrZFR2atmq2HV8_A_4KLxoQX1NRFWl5whdmQdtuR3P8SxKWvsit5I_rGPAmp5yc=s144-w108-h144-n-k-no"], links: nil, placeID: nil, placeIDSearch: nil, providerID: nil, gpsCoordinates:nil,address: "", hours: "Bengaluru, Karnataka, India", phone: "Open · Closes 9 PM"),
            LocalResult(position: 2, title: "Karnataka Coffee Board Coffee Shop", type:"Coffee shop", rating: 4, reviews: 148, price: "₹1–200", description: "U can experience best taste of coffee.", lsig: "AB86z5XqQwjTG91EPvs2Rjiguduf", images: [ "https://lh3.googleusercontent.com/gps-cs-s/AHVAwepTwlcif38MRV6hijuzNA1Clds1vvGYIVVTHexeToRd9gpQskXcuKRkgHOSHIAPnnMIeejw4MlPLywNFWEMKdxs7IWEKxZ9g6DkTwE12e6MjGBDe3dOb_xM3Lpiupk_QkdqCUg=s144-w108-h144-n-k-no"], links: nil, placeID: nil, placeIDSearch: nil, providerID: nil, gpsCoordinates:nil,address: "", hours: "Bengaluru, Karnataka, India", phone: "Open · Closes 9 PM")
        ]
        let mockVenue: Venue = Venue(searchMetadata: nil, searchParameters: nil, localMap: nil, localResults: localResultsVal, pagination: nil, serpapiPagination: nil)
        return mockVenue
    }
    
    static func getMockDataVenueCacheTest() -> Venue {

        let localResultsVal: [LocalResult] = [
            LocalResult(position: 1, title: "Cached Cafe", type:"Coffee shop", rating: 4.4, reviews: 29, price: "₹1–200", description: "Super delicious authentic coffee.", lsig: "AB86z5UbkLkm1UxOoP8qgqk-Gh4v", images: [ "https://lh3.googleusercontent.com/gps-cs-s/AHVAwercLwd70sGUTDZFxHUExj0IQfwsBkn7kqN9XVVoouF1oXW6_pvGgBUSlmIIRrk6bPot7reohHrZFR2atmq2HV8_A_4KLxoQX1NRFWl5whdmQdtuR3P8SxKWvsit5I_rGPAmp5yc=s144-w108-h144-n-k-no"], links: nil, placeID: nil, placeIDSearch: nil, providerID: nil, gpsCoordinates:nil,address: "", hours: "Bengaluru, Karnataka, India", phone: "Open · Closes 9 PM")
        ]
        let mockVenue: Venue = Venue(searchMetadata: nil, searchParameters: nil, localMap: nil, localResults: localResultsVal, pagination: nil, serpapiPagination: nil)
        return mockVenue
    }
}
