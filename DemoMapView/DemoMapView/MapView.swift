//
//  MapView.swift
//  DemoMapView
//
//

import SwiftUI
import MapKit

struct MapView: View {

    // MARK: - Camera Position
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    // MARK: - Sample Locations
    let locations: [LocationModel] = [
        LocationModel(coordinate: CLLocationCoordinate2D(latitude: 37.7879, longitude: -122.4074), name: "Union Square"),
        LocationModel(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), name: "Market Street")
    ]

    var body: some View {
        Map(position: $position) {

            // MARK: - Multiple Annotations
            ForEach(locations) { location in
                Annotation(location.name, coordinate: location.coordinate) {

                    // MARK: - Custom Pin View
                    VStack(spacing: 4) {
                        Text(location.name)
                            .font(.caption)
                            .padding(6)
                            .background(.white)
                            .cornerRadius(6)
                            .shadow(radius: 2)

                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .mapStyle(.standard)
        .ignoresSafeArea()
    }
}
