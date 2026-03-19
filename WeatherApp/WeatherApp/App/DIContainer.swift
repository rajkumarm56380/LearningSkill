//
//  DIContainer.swift
//  WeatherApp
//
//  Created by Apple on 19/03/26.
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
