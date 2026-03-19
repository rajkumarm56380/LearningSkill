//
//  LocationServiceProtocol.swift
//  DemoLocationApp
//
//

import Combine
import CoreLocation

protocol LocationServiceProtocol {
    var locationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> { get }
    func requestLocation()
}
