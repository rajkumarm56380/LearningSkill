//
//  MockVenueUseCase.swift
//  DemoVenuesAppTests
//
//

import Combine
import Foundation

class MockVenueUseCase: GetNearbyVenuesUseCaseProtocol {

    enum MockScenario {
            case apiSuccess
            case apiFailure
            case emptyResponse
            case cachedData
            case offline
        }

        var scenario: MockScenario = .apiSuccess

        func execute() -> AnyPublisher<Venue, Error> {

            switch scenario {

            case .apiSuccess:

                return Just(VenueMockData.getMockDataVenueTest())
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()

            case .cachedData:
                return Just(VenueMockData.getMockDataVenueCacheTest())
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()

            case .emptyResponse:

                guard let mock = VenueMockData.loadVenues() else {
                    return Empty<Venue, Error>(completeImmediately: true).eraseToAnyPublisher()
                }

                return Just(mock)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()

            case .apiFailure:

                return Fail(error: URLError(.badServerResponse))
                    .eraseToAnyPublisher()

            case .offline:

                return Fail(error: URLError(.notConnectedToInternet))
                    .eraseToAnyPublisher()
            }
        }
}

