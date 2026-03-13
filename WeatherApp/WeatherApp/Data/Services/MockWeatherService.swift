//
//  MockWeatherService.swift
//  WeatherApp
//
//  Created by Apple on 13/03/26.
//

import Combine
import Foundation

protocol MockWeatherServiceProtocol {
    func fetchMockWeather() -> AnyPublisher<Weather, Error>
}

final class MockWeatherService: MockWeatherServiceProtocol {

    var shouldFail = false

    func fetchMockWeather() -> AnyPublisher<Weather, Error> {

//        if shouldFail {
//            return Fail(error: URLError(.badServerResponse))
//                .eraseToAnyPublisher()
//        }
        let mock = Weather(temperature: 28.5,windspeed: 8.2)
        return Just(mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
}
