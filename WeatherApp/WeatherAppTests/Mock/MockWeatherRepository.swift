//
//  MockWeatherService.swift
//  WeatherApp
//
//

import Combine
import Foundation

final class MockWeatherRepository: WeatherRepositoryProtocol {

    var temperature: Double = 25.0
    var shouldFail = false

    func fetchWeather() -> AnyPublisher<Weather, Error> {

        if shouldFail {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }

        let weather = Weather(
            temperature: temperature,
            windspeed: 5.5
        )

        return Just(weather)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
