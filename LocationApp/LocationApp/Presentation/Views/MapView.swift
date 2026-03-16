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
/*
            MapReader { proxy in

                        Map(position: .constant(.region(viewModel.region))) {

                            ForEach(viewModel.locations) { location in
                                Annotation(location.name, coordinate: location.coordinate) {
                                    Image(systemName: "mappin.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.red)
                                }
                                
                            }
                        }
                        .onTapGesture { screenPoint in

                            if let coordinate = proxy.convert(screenPoint, from: .local) {
                                viewModel.addPin(coordinate)
                            }

                        }
                        if let location = viewModel.selectedLocation {
                            LocationDetailPopup(location: location)
                        }
                    }
*/
            ZStack {
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
            }
            .ignoresSafeArea()
        }
}
