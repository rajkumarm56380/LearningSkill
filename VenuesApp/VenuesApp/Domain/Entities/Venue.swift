//
//  Venue.swift
//  VenuesApp
//
//  Created by Apple on 14/03/26.
//

import Foundation

struct VenueList: Codable {
    let venueList: [Venue]
}
// MARK: - Venue
struct Venue:Identifiable, Codable {
    let id = UUID()
    let placeID: Int
    let licence, osmType: String
    let osmID: Int
    let lat, lon, venueClass, type: String
    let placeRank: Int
    let importance: Double
    let addresstype, name, displayName: String
    let address: Address
    let boundingbox: [String]

    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case licence
        case osmType = "osm_type"
        case osmID = "osm_id"
        case lat, lon
        case venueClass = "class"
        case type
        case placeRank = "place_rank"
        case importance, addresstype, name
        case displayName = "display_name"
        case address, boundingbox
    }
}

// MARK: - Address
struct Address: Codable {
    let stateDistrict, state: String?
    let iso31662Lvl4, country, countryCode: String
    let city, county, village, town: String?
    let province, region: String?

    enum CodingKeys: String, CodingKey {
        case stateDistrict = "state_district"
        case state
        case iso31662Lvl4 = "ISO3166-2-lvl4"
        case country
        case countryCode = "country_code"
        case city, county, village, town, province, region
    }
}
