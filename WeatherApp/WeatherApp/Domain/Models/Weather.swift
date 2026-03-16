//
//  Weather.swift
//  WeatherApp
//
//

import Foundation

struct Weather: Codable {
    let temperature: Double
    let windspeed: Double
}

struct WeatherReponse: Codable {
    let current_weather: Weather
}
