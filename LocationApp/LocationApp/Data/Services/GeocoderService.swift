//
//  GeocoderService.swift
//  LocationApp
//
//

import CoreLocation
import Combine

class GeocoderService {

    func getAddress(from coordinate: CLLocationCoordinate2D) -> AnyPublisher<LocationModel, Never> {

        Future { promise in
            let location = CLLocation(latitude: coordinate.latitude,
                                      longitude: coordinate.longitude)

            CLGeocoder().reverseGeocodeLocation(location) { placemarks, _ in
                promise(.success( self.getLocationDetails(placeMark: placemarks,coordinate: coordinate)))
            }
        }
        .eraseToAnyPublisher()
    }

    private func getLocationDetails(placeMark: [CLPlacemark]? , coordinate: CLLocationCoordinate2D) -> LocationModel {
        let locationDetail = LocationModel(coordinate: coordinate,
        name: placeMark?.first?.name ?? "",
        address: (getLegacyFormattedAddress(from: placeMark) ?? placeMark?.first?.administrativeArea) ?? "",
        postalCode: placeMark?.first?.postalCode ?? "",
        country: placeMark?.first?.country ?? "",
        subLocality: placeMark?.first?.subLocality ?? "",
        subAdministrativeArea: placeMark?.first?.subAdministrativeArea ?? "",
        locality: placeMark?.first?.locality ?? "")
        return locationDetail
    }
    func getLegacyFormattedAddress(from placemark: [CLPlacemark]?) -> String? {
        let name = placemark?.first?.name
        let subThoroughfare = placemark?.first?.subThoroughfare
        let thoroughfare = placemark?.first?.thoroughfare
        let streetAddress = "\(subThoroughfare ?? "") \(thoroughfare ?? "")"
        let locality = placemark?.first?.locality
        let postalCode = placemark?.first?.postalCode
        let country = placemark?.first?.country

        let address: String = "\(name ?? ""), \(streetAddress), \(locality ?? ""), \(postalCode ?? ""), \(country ?? "")"
        return address
    }

}
