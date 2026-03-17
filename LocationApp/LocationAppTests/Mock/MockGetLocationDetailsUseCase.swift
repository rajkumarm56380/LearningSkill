//
//  MockGetLocationDetailsUseCase.swift
//  LocationAppTests
//
//

import Combine
import MapKit

class MockGetLocationDetailsUseCase: GetLocationDetailsUseCase {

    var mockLocation = LocationModel(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
    name: "Mock",
    address: "Mock Address",
    postalCode: "",
    country: "",
    subLocality: "",
    subAdministrativeArea: "",
    locality: "")


    override func execute(coordinate: CLLocationCoordinate2D)
    -> AnyPublisher<LocationModel, Never> {

        Just(mockLocation)
            .eraseToAnyPublisher()
    }
}
