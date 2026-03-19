//
//  WeatherViewModel.swift
//  WeatherApp
//
//

import Combine
import Foundation

final class WeatherViewModel: ObservableObject {
    @Published var temperature: String = "25.0 °C"
    @Published var windspeed: String = "--"
    @Published var isLoading = false
    @Published var isOffline = false
    @Published var errorMessage: String?

    private let useCase: FetchWeatherUseCase
    private var cancellables = Set<AnyCancellable>()

    init(useCase: FetchWeatherUseCase) {
        self.useCase = useCase
        NetworkMonitor.shared.$isConnected
            .map{!$0}
            .assign(to: &$isOffline)
    }

    func fetchWeather() {
        isLoading = true

        useCase.execute()
            .receive(on: DispatchQueue.main)
            .sink{ completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { weather in
                self.temperature = "\(weather.temperature) °C"
                self.windspeed = "\(weather.windspeed) km/h"
            }
            .store(in: &cancellables)
    }
}
