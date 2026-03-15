//
//  MockUseCase.swift
//  VenuesAppTests
//
//  Created by Apple on 14/03/26.
//

import Combine

class MockUseCase: GetNearbyVenuesUseCaseProtocol {
    func execute() -> AnyPublisher <[Venue], Never> {
        return Just(VenueMockData.loadVenues())
            .eraseToAnyPublisher()
    }
}
