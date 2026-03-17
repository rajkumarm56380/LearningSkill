//
//  GeocoderServiceProtocol.swift
//  LocationApp
//
//

import Combine
import CoreLocation

protocol GeocoderServiceProtocol {
    func getAddress(from coordinate: CLLocationCoordinate2D) -> AnyPublisher<LocationModel, Never>
}
