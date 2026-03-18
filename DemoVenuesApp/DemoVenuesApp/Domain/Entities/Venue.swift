//
//  Venue.swift
//  DemoVenuesApp
//
//

import Foundation

// MARK: - Venues
struct Venue: Codable {
    let searchMetadata: SearchMetadata?
    let searchParameters: SearchParameters?
    let localMap: LocalMap?
    let localResults: [LocalResult]
    let pagination, serpapiPagination: Pagination?

    enum CodingKeys: String, CodingKey {
        case searchMetadata = "search_metadata"
        case searchParameters = "search_parameters"
        case localMap = "local_map"
        case localResults = "local_results"
        case pagination
        case serpapiPagination = "serpapi_pagination"
    }
}

// MARK: - LocalMap
struct LocalMap: Codable {
    let image: String?
    let gpsCoordinates: GpsCoordinates?

    enum CodingKeys: String, CodingKey {
        case image
        case gpsCoordinates = "gps_coordinates"
    }
}

// MARK: - GpsCoordinates
struct GpsCoordinates: Codable {
    let latitude, longitude: Double?
}

// MARK: - LocalResult
struct LocalResult: Identifiable, Codable {
    let id = UUID()
    let position: Int
    let title: String
    let type: String
    let rating: Double
    let reviews: Int
    let price: String?
    let description, lsig: String
    let images: [String]
    let links: Links?
    let placeID: String?
    let placeIDSearch: String?
    let providerID: String?
    let gpsCoordinates: GpsCoordinates?
    let address, hours: String
    let phone: String?

    enum CodingKeys: String, CodingKey {
        case position, title, type, rating, reviews, price, description, lsig, images, links
        case placeID = "place_id"
        case placeIDSearch = "place_id_search"
        case providerID = "provider_id"
        case gpsCoordinates = "gps_coordinates"
        case address, hours, phone
    }
}

// MARK: - Links
struct Links: Codable {
    let directions: String?
    let phone: String?
    let website: String?
}

enum TypeEnum: String, Codable {
    case cafe = "Cafe"
    case coffeeShop = "Coffee shop"
}

// MARK: - Pagination
struct Pagination: Codable {
    let current: Int?
    let next: String?
    let otherPages: [String: String]?
    let nextLink: String?

    enum CodingKeys: String, CodingKey {
        case current, next
        case otherPages = "other_pages"
        case nextLink = "next_link"
    }
}

// MARK: - SearchMetadata
struct SearchMetadata: Codable {
    let id, status: String?
    let jsonEndpoint: String?
    let createdAt, processedAt: String?
    let googleLocalURL: String?
    let rawHTMLFile: String?
    let totalTimeTaken: Double?

    enum CodingKeys: String, CodingKey {
        case id, status
        case jsonEndpoint = "json_endpoint"
        case createdAt = "created_at"
        case processedAt = "processed_at"
        case googleLocalURL = "google_local_url"
        case rawHTMLFile = "raw_html_file"
        case totalTimeTaken = "total_time_taken"
    }
}

// MARK: - SearchParameters
struct SearchParameters: Codable {
    let engine, q, locationRequested, locationUsed: String?
    let googleDomain, hl, gl, device: String?

    enum CodingKeys: String, CodingKey {
        case engine, q
        case locationRequested = "location_requested"
        case locationUsed = "location_used"
        case googleDomain = "google_domain"
        case hl, gl, device
    }
}
