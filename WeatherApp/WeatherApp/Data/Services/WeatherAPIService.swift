//
//  WeatherAPIService.swift
//  WeatherApp
//
//  Created by User on 23/03/26.
//

import Combine
import CoreLocation

protocol WeatherAPIServiceProtocol {
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<Weather ,Error>
}

final class WeatherAPIService: WeatherAPIServiceProtocol {

    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<Weather, Error> {
        let urlString = """
                https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current_weather=true
                """
        print("urlString ==> \(urlString)")
        let url = URL(string: urlString)!

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherReponse.self, decoder: JSONDecoder())
            .map{ $0.current_weather }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
