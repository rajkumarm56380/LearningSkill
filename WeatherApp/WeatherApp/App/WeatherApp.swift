//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by user on 13/03/26.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            let locationService = LocationService()
            let apiService = WeatherAPIService()
            let mockService = MockWeatherService()

            let repository = WeatherRepository(
                locationService: locationService,
                apiService: apiService,
                mockService: mockService
            )

            let useCase = FetchWeatherUseCase(repository: repository)
            let viewModel = WeatherViewModel(useCase: useCase)
            WeatherView(viewModel: viewModel)
        }
    }
}
