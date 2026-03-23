//
//  MapView.swift
//  LocationApp
//
//

import SwiftUI
import MapKit

struct MapView: View {

    @StateObject var viewModel: MapViewModel

    var body: some View {

        ZStack {
            
            Map(position: $viewModel.mapPosition) {
                        Annotation("Union Square",
                                   coordinate: CLLocationCoordinate2D(latitude: 37.7879, longitude: -122.4074)) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                                .font(.title)
                        }
                    }
                    .mapStyle(.standard)
                    .ignoresSafeArea()

            MapReader { proxy in
                Map(position: $viewModel.mapPosition) {

                    ForEach(viewModel.locations) { location in
                        Annotation(
                            location.name.isEmpty ? "Pinned Location" : location.name,
                            coordinate: location.coordinate
                        ) {
                            Button(action: {
                                viewModel.selectLocation(location)
                            }) {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(.red)
                                    .shadow(radius: 2)
                            }
                            .buttonStyle(.plain)
                            .accessibilityIdentifier("map_pin")
                        }
                    }
                }
                .accessibilityIdentifier("mapView")
                .gesture(
                    DragGesture(minimumDistance: 100)
                        .onEnded { value in
                            if let coordinate = proxy.convert(value.location, from: .local) {
                                viewModel.addPin(coordinate)
                            }
                        }
                )
                .onTapGesture { screenPoint in
                    if let coordinate = proxy.convert(screenPoint, from: .local)
                    {
                        viewModel.addPin(coordinate)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            // MARK: - Lifecycle
            .onAppear {
                viewModel.getCurrentLocation()
            }

            // MARK: - UI Testing Support
            .overlay {
                if ProcessInfo.processInfo.arguments.contains("UI_TEST_MODE") {
                    Color.clear
                        .accessibilityIdentifier("mapView")
                }
            }

            // ✅ TEST HOOK (IMPORTANT)
                ForEach(viewModel.locations) { location in
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 20, height: 20)
                        .accessibilityIdentifier("map_pin")
                }
            if let location = viewModel.selectedLocation {
                VStack {
                    LocationDetailPopup(location: location)
                }
                .accessibilityElement(children: .contain)
                .accessibilityIdentifier("location_popup") // ✅ APPLY HERE
                .zIndex(1)
            }
        }
        .ignoresSafeArea()
    }
}

