//
//  LocationRepositoryProtocol.swift
//  LocationApp
//
//

import Combine
import CoreLocation
import Foundation

protocol LocationRepositoryProtocol {
    func getAddress(for coordinate: CLLocationCoordinate2D) -> AnyPublisher<LocationModel, Never>
}
