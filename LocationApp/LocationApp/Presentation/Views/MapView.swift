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
            MapReader { proxy in
                if ProcessInfo.processInfo.arguments.contains("UI_TEST_MODE") {
                    Color.gray
                        .accessibilityIdentifier("mapView")
                } else {
                    Map(position: $viewModel.mapPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {

                                Image(systemName: "mappin.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.red)
                                    .accessibilityIdentifier("map_pin")
                                    .onTapGesture {
                                        viewModel.selectedLocation = location
                                    }
                            }
                        }
                    }.accessibilityIdentifier("mapView")
                        .onAppear {
                            viewModel.getCurrentLocation()
                        }
                        .onTapGesture { screenPoint in
                            if let coordinate = proxy.convert(screenPoint, from: .local) {
                                viewModel.addPin(coordinate)
                            }
                        }
                }
            }
            // MARK: - UI Testing Support
            .overlay {
                if ProcessInfo.processInfo.arguments.contains("UI_TEST_MODE") {
                Color.clear .accessibilityIdentifier("mapView") }
            }

            if let location = viewModel.selectedLocation {
                LocationDetailPopup(location: location)
                    .zIndex(1)
            }
        }
        .ignoresSafeArea()
    }
}

/*ZStack {
 Map(
 coordinateRegion: $viewModel.region,
 annotationItems: viewModel.locations
 ) { location in

 MapAnnotation(coordinate: location.coordinate) {
 //    Annotation("Label", coordinate: item.coordinate) {
 VStack {
 Image(systemName: "mappin.circle.fill")
 .font(.title)
 .foregroundColor(.red)
 .onTapGesture {
 viewModel.selectedLocation = location
 }

 Text(location.name)
 .font(.headline)
 }
 }
 }
 .onAppear {
 viewModel.getCurrentLocation()
 }
 .gesture(
 TapGesture()
 .onEnded { value in
 DispatchQueue.main.async {
 let coordinate =  self.viewModel.region.center
 self.viewModel.addPin(coordinate)
 }
 }
 )

 if let location = viewModel.selectedLocation {
 LocationDetailPopup(location: location)
 }
 }*/
