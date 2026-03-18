//
//  LocationRepository.swift
//  LocationApp
//
//

import Combine
import CoreLocation

class LocationRepository: LocationRepositoryProtocol {

    private let geocoder: GeocoderServiceProtocol

    init(geocoder: GeocoderServiceProtocol = GeocoderService()) {
        self.geocoder = geocoder
    }

    func getAddress(for coordinate: CLLocationCoordinate2D) -> AnyPublisher<LocationModel, Never> {
        geocoder.getAddress(from: coordinate)
    }
}
