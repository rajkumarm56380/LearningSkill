//
//  WeatherRepository.swift
//  WeatherApp
//
//

import Combine
import CoreGraphics

final class WeatherRepository: WeatherRepositoryProtocol {

    private let locationService: LocationService
    private let apiService: WeatherAPIServiceProtocol
    private let mockService: MockWeatherServiceProtocol
    private let networkMonitor: NetworkMonitor

    init(locationService: LocationService,
            apiService: WeatherAPIServiceProtocol,
            mockService: MockWeatherServiceProtocol,
            networkMonitor: NetworkMonitor = .shared) {
           self.locationService = locationService
           self.apiService = apiService
           self.mockService = mockService
           self.networkMonitor = networkMonitor
       }

    func fetchWeather() -> AnyPublisher<Weather,Error> {
        if networkMonitor.isConnected {
            return locationService
                .requestLocaton()
                .flatMap { location in
                    self.apiService.fetchWeather(
                        lat: location.coordinate.latitude,
                        lon: location.coordinate.longitude
                    )
                }
                .eraseToAnyPublisher()

        } else {
            return mockService.fetchMockWeather()
        }
    }
}
