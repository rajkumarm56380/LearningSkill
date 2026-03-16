//
//  LocationModel.swift
//  LocationApp
//
//

import Foundation
import CoreLocation

struct LocationModel: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
        let name: String
        let address: String
        let postalCode: String
        let country: String
        let subLocality: String
        let subAdministrativeArea: String
        let locality: String
}
