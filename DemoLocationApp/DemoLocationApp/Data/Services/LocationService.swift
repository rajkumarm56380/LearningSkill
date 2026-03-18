//
//  LocationService.swift
//  LocationApp
//
//

import CoreLocation
import Combine

class LocationService: NSObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()
    let locationPublisher = PassthroughSubject<CLLocationCoordinate2D, Never>()

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
        locationPublisher.send(coordinate)
    }
}
