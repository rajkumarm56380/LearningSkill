//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//

import XCTest
import Combine
@testable import WeatherApp

final class FetchWeatherUseCaseTests: XCTestCase {

    private var useCase: FetchWeatherUseCaseProtocol!
    private var mockRepository: MockWeatherRepository!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {

        mockRepository = MockWeatherRepository()
        mockRepository.temperature = 15.8

        useCase = FetchWeatherUseCase(repository: mockRepository)
    }

    func testUseCaseReturnsWeather() {

        let expectation = XCTestExpectation(description: "UseCase returns weather")

        useCase.execute()
            .sink(receiveCompletion: { _ in }) { weather in

                XCTAssertEqual(weather.temperature, 15.8)
                XCTAssertEqual(weather.windspeed, 5.5)

                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }
}
