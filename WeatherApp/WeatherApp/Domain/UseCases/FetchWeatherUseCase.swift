//
//  FetchWeatherUseCase.swift
//  WeatherApp
//
//  Created by User on 23/03/26.
//

import Combine

final class FetchWeatherUseCase {

    private let repository: WeatherRepositoryProtocol

    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<Weather, Error> {
        repository.fetchWeather()
    }
}
