//
//  LocationModel.swift
//  LocationApp
//
//

import Foundation
import CoreLocation

struct LocationModel: Identifiable {
        let id = UUID()
        var coordinate: CLLocationCoordinate2D
        var name: String
        var address: String?
        var postalCode: String?
        var country: String?
        var subLocality: String?
        var subAdministrativeArea: String?
        var locality: String?
}
