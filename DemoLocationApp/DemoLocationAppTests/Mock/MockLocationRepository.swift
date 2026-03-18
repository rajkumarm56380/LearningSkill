//
//  MockLocationRepository.swift
//  LocationAppTests
//
//

import Combine
import MapKit

class MockLocationRepository: LocationRepositoryProtocol {

    var mockLocation = LocationModel(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
    name: "Mock",
    address: "Mock Address")
    
    func getAddress(for coordinate: CLLocationCoordinate2D) -> AnyPublisher<LocationModel, Never> {
        Just(mockLocation)
            .eraseToAnyPublisher()
    }

}
