//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by Apple on 13/03/26.
//

import XCTest
import Combine
@testable import WeatherApp

final class WeatherViewModelTests: XCTestCase {

    private var viewModel: WeatherViewModel!
    private var locationService = LocationService()
    private var apiService = WeatherAPIService()
    private var mockService = MockWeatherService()
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        let repository = WeatherRepository(
                        locationService: locationService,
                        apiService: apiService,
                        mockService: mockService
                    )
        let useCase = FetchWeatherUseCase(repository: repository)
        viewModel = WeatherViewModel(useCase: useCase)
        cancellables = []
    }

    override func tearDown() {

        viewModel = nil
        cancellables = nil
    }

    func testFetchWeatherSuccess() {

        let expectation = XCTestExpectation(
            description: "Weather fetched successfully"
        )

        viewModel.$temperature
            .dropFirst()
            .sink { value in

                XCTAssertEqual(value, "9.2 °C")

                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchWeather()
        wait(for: [expectation], timeout: 5)
    }

    func testFetchWeatherFailure() {

        mockService.shouldFail = true
        let expectation = XCTestExpectation(
            description: "Weather fetch fails"
        )

        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                
                XCTAssertNotNil(error)

                expectation.fulfill()

            }
            .store(in: &cancellables)

        viewModel.fetchWeather()
        wait(for: [expectation], timeout: 5)
    }
}
