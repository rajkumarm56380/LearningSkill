//
//  LocationRepository.swift
//  LocationApp
//
//

import Combine
import CoreLocation

class LocationRepository: LocationRepositoryProtocol {

    private let geocoder = GeocoderService()

    func getAddress(for coordinate: CLLocationCoordinate2D) -> AnyPublisher<LocationModel, Never> {
        geocoder.getAddress(from: coordinate)
    }
}
