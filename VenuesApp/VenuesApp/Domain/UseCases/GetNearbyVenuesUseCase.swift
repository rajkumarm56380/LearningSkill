//
//  GetNearbyVenuesUseCase.swift
//  VenuesApp
//
//  Created by Apple on 14/03/26.
//

import Combine

protocol GetNearbyVenuesUseCaseProtocol {
    func execute() -> AnyPublisher<[Venue], Never>
}

final class GetNearbyVenuesUseCase: GetNearbyVenuesUseCaseProtocol {

    private let repository: VenueRepositoryProtocol

    init(repository: VenueRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[Venue], Never> {
        repository.getNearByVenues()
    }
}
