//
//  DIContainer.swift
//  WeatherApp
//
//

import Foundation

final class DIContainer {

    func makeWeatherViewModel() -> WeatherViewModel {
        let locationService = LocationService()
        let apiService = WeatherAPIService()
        let mockRepository = MockWeatherService()

        let repository = WeatherRepository(
            locationService: locationService,
            apiService: apiService,
            mockService: mockRepository
        )

        let useCase = FetchWeatherUseCase(repository: repository)
        return WeatherViewModel(useCase: useCase)
    }
}
