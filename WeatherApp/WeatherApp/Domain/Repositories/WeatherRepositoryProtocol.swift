//
//  WeatherRepositoryProtocol.swift
//  WeatherApp
//
//

import Foundation
import Combine
import CoreLocation

protocol WeatherRepositoryProtocol {
    func fetchWeather() -> AnyPublisher<Weather, Error>
}
