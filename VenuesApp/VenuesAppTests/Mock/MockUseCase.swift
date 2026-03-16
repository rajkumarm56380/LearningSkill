//
//  MockUseCase.swift
//  VenuesAppTests
//
//

import Combine

class MockUseCase: GetNearbyVenuesUseCaseProtocol {
    func execute() -> AnyPublisher <[Venue], Never> {
        return Just(VenueMockData.loadVenues())
            .eraseToAnyPublisher()
    }
}
