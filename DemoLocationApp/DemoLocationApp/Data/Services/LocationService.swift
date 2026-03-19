//
//  LocationService.swift
//  LocationApp
//
//

import CoreLocation
import Combine

class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol {

    private let manager = CLLocationManager()
    private let subject = PassthroughSubject<CLLocationCoordinate2D, Never>()

    var locationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> {
        subject.eraseToAnyPublisher()
    }

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        subject.send(coordinate)
    }
}
