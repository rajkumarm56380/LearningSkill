//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherViewModelTests: XCTestCase {

    private var viewModel: WeatherViewModel!
    private var mockRepository: MockWeatherRepository!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {

        mockRepository = MockWeatherRepository()
        mockRepository.temperature = 15.8

        let useCase = FetchWeatherUseCase(repository: mockRepository)

        viewModel = WeatherViewModel(useCase: useCase)
        cancellables = []
    }

    func testFetchWeatherSuccess() {

        let expectation = XCTestExpectation(description: "Weather fetched successfully")

        viewModel.$temperature
            .dropFirst()
            .sink { value in
                XCTAssertEqual(value, "15.8 °C")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchWeather()

        wait(for: [expectation], timeout: 2)
    }

    func testFetchWeatherFailure() {

        mockRepository.shouldFail = true

        let expectation = XCTestExpectation(description: "Weather fetch fails")

        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchWeather()

        wait(for: [expectation], timeout: 2)
    }
}
