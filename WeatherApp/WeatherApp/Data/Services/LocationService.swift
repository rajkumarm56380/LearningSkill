//
//  LocationService.swift
//  WeatherApp
//
//  Created by User on 23/03/26.
//

import Combine
import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {

    //MARK:- Constants
    private var locationManager = CLLocationManager()
    private let locationSubject = PassthroughSubject<CLLocation, Error>()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    //MARK:- Functions

    func requestLocaton() -> AnyPublisher<CLLocation, Error> {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        return locationSubject.eraseToAnyPublisher()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationSubject.send(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        locationSubject.send(completion: .failure(error))
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("Status: Not Determined. Requesting authorization...")
            // You can request authorization here if needed
             locationManager.requestLocation()
        case .restricted:
            print("Status: Restricted. Parental controls or similar restrictions are active.")
        case .denied:
            print("Status: Denied. User explicitly denied access.")
            // You can inform the user here that location services are needed
        case .authorizedAlways:
            print("Status: Authorized Always. Full access granted.")
            if status == .authorizedAlways {
                    if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                        if CLLocationManager.isRangingAvailable() {
                            // do stuff
                        }
                    }
                }
        case .authorizedWhenInUse:
            print("Status: Authorized When In Use. Access granted while the app is in the foreground.")
        @unknown default:
            print("Unknown status")
        }
    }

}
