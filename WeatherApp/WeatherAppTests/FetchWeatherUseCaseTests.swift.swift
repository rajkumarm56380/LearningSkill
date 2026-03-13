//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by user on 13/03/26.
//

import XCTest
import Combine
@testable import WeatherApp

final class FetchWeatherUseCaseTests: XCTestCase {

    private var useCase: FetchWeatherUseCase!
    private let locationService = LocationService()
    private let apiService = WeatherAPIService()
    private let mockService = MockWeatherService()
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        let repository = WeatherRepository(
                        locationService: locationService,
                        apiService: apiService,
                        mockService: mockService
                    )
        useCase = FetchWeatherUseCase(repository: repository)
    }

    func testUseCaseReturnsWeather() {
        let expectation = XCTestExpectation(
            description: "UseCase returns weather"
        )

        useCase.execute()
            .sink { _ in }
        receiveValue: { weather in

            XCTAssertEqual(weather.temperature, 28.5)
            XCTAssertEqual(weather.windspeed, 8.2)

            expectation.fulfill()
        }
        .store(in: &cancellables)
        wait(for: [expectation], timeout: 5)
    }
}
