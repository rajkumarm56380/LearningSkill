//
//  FetchWeatherUseCase.swift
//  WeatherApp
//
//

import Foundation
import Combine

protocol FetchWeatherUseCaseProtocol {
    func execute() -> AnyPublisher<Weather, Error>
}

final class FetchWeatherUseCase: FetchWeatherUseCaseProtocol {

    private let repository: WeatherRepositoryProtocol

    // Dependency Injection
    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }

    // Execute business logic
    func execute() -> AnyPublisher<Weather, Error> {

        return repository
            .fetchWeather()
            .eraseToAnyPublisher()
    }
}
