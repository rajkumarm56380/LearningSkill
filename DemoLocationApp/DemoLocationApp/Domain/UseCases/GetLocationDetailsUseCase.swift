//
//  GetLocationDetailsUseCase.swift
//  LocationApp
//
//

import Combine
import CoreLocation

class GetLocationDetailsUseCase {

    private let repository: LocationRepositoryProtocol

    init(repository: LocationRepositoryProtocol) {
        self.repository = repository
    }

    func execute(coordinate: CLLocationCoordinate2D)
    -> AnyPublisher<LocationModel, Never> {

        repository.getAddress(for: coordinate)
            .map { value in
                LocationModel(coordinate: coordinate,
                              name: value.name,
                              address: value.address,
                              postalCode: value.postalCode,
                              country: value.country,
                              subLocality: value.subLocality,
                              subAdministrativeArea: value.subAdministrativeArea,
                              locality: value.locality)
            }
            .eraseToAnyPublisher()
    }
}
