//
//  Weather.swift
//  WeatherApp
//
//  Created by User on 23/03/26.
//

import Foundation

struct Weather: Codable {
    let temperature: Double
    let windspeed: Double
}

struct WeatherReponse: Codable {
    let current_weather: Weather
}
