//
//  GetNearbyVenuesUseCase.swift
//  VenuesApp
//
//

import Combine

protocol GetNearbyVenuesUseCaseProtocol {
    func execute() -> AnyPublisher<Venue, Error>
}

final class GetNearbyVenuesUseCase: GetNearbyVenuesUseCaseProtocol {

    private let repository: VenueRepositoryProtocol

    init(repository: VenueRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<Venue, Error> {
        repository
            .getNearByVenues()
            .eraseToAnyPublisher()
    }
}
