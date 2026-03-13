//
//  WeatherRepositoryProtocol.swift
//  WeatherApp
//
//  Created by User on 23/03/26.
//

import Foundation
import Combine
import CoreLocation

protocol WeatherRepositoryProtocol {
    func fetchWeather() -> AnyPublisher<Weather, Error>
}
