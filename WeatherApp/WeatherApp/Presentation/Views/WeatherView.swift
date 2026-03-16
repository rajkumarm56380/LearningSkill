//
//  WeatherView.swift
//  WeatherApp
//
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Weather PoC")
                .font(.largeTitle)

            if viewModel.isOffline {
                Text("Offline Mode (Mock Data)")
                    .foregroundColor(.orange)
            }

            Text("Temperature: \(String(describing: viewModel.temperature))")
            Text("Wind Speed: \(String(describing: viewModel.windspeed))")

            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .background(.ultraThinMaterial)
            }
       }.padding()
        .onAppear() {
                viewModel.fetchWeather()
        }
    }
}

