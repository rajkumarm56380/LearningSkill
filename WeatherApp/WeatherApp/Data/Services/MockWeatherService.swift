//
//  MockWeatherService.swift
//  WeatherApp
//
//

import Combine

final class MockWeatherService {

    func fetchMockWeather() -> AnyPublisher<Weather, Error> {

        let mock = Weather(
            temperature: 28.5,
            windspeed: 8.2
        )

        return Just(mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
