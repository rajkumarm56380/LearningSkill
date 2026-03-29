//
//  WeatherView.swift
//  WeatherApp
//
//

import SwiftUI
import SharedUIKits

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Weather PoC")
                    .font(.largeTitle)

                if viewModel.isOffline {
                    Text("Offline Mode (Mock Data)")
                        .foregroundColor(.orange)
                }

                Text("Temperature: \(String(describing: viewModel.temperature))")
                Text("Wind Speed: \(String(describing: viewModel.windspeed))")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .loading(viewModel.isLoading)
        .task {
            viewModel.fetchWeather()
        }
    }
}

