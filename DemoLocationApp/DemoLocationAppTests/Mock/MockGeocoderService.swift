//
//  MockGeocoderService.swift
//  LocationAppTests
//
//

import Combine
import MapKit

class MockGeocoderService: GeocoderServiceProtocol {

    var mockLocation: LocationModel = LocationModel(coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 10),
                                               name: "Mock",
                                               address: "Mock Address",
                                               postalCode: "",
                                               country: "",
                                               subLocality: "",
                                               subAdministrativeArea: "",
                                               locality: "")
    var isCalled = false

    func getAddress(from coordinate: CLLocationCoordinate2D)
    -> AnyPublisher<LocationModel, Never> {

        isCalled = true
        return Just(mockLocation)
            .eraseToAnyPublisher()
    }
}
