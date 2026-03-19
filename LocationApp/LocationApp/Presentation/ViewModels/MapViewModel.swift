//
//  MapViewModel.swift
//  LocationApp
//
//

import SwiftUI
import Combine
import MapKit

@MainActor
class MapViewModel: ObservableObject {

    // MARK: - Map State
    @Published var mapPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )

    // MARK: - UI State
    @Published var locations: [LocationModel] = []
    @Published var selectedLocation: LocationModel?

    // MARK: - Dependencies
    private let locationService: LocationService
    private let useCase: GetLocationDetailsUseCase
    private var cancellables = Set<AnyCancellable>()
    private let spanCoordinate = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

    // MARK: - Init
    init(locationService: LocationService = LocationService(), useCase: GetLocationDetailsUseCase) {
        self.locationService = locationService
        self.useCase = useCase
        bindLocation()
    }


    // MARK: - Bind Current Location
    private func bindLocation() {

        locationService.locationPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] coordinate in
                guard let self = self else { return }

                // Move camera to current location
                self.mapPosition = .region(
                    MKCoordinateRegion(
                        center: coordinate,
                        span: spanCoordinate
                    )
                )

                // Avoid duplicate pins
                if !self.isDuplicate(coordinate) {
                    self.addPin(coordinate)
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Public Actions
    func getCurrentLocation() {
        locationService.requestLocation()
    }


    func addPin(_ coordinate: CLLocationCoordinate2D) {

        let newLocation = LocationModel(
            coordinate: coordinate,
            name: "",
            address: "Loading..."
        )

        if !isDuplicate(coordinate) {
            locations.append(newLocation)
            selectedLocation = newLocation
        }

        mapPosition = .region(
            MKCoordinateRegion(
                center: coordinate,
                span: spanCoordinate
            )
        )

        useCase.execute(coordinate: coordinate)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in
                guard let self else { return }

                if let index = self.locations.firstIndex(where: { $0.id == newLocation.id }) {
                    self.locations[index] = location
                    self.selectedLocation = location
                }
            }
            .store(in: &cancellables)
    }
  /*  func addPin(_ coordinate: CLLocationCoordinate2D) {

        let newLocation = LocationModel(
            coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                name:"NA",
                address: "Loading..."
            )

            // ✅ Add immediately
            if !locations.contains(where: {
                $0.coordinate.latitude == coordinate.latitude &&
                $0.coordinate.longitude == coordinate.longitude
            }) {
                locations.append(newLocation)
                selectedLocation = newLocation
            }

            // ✅ Update map position (THIS is missing in your case)
            mapPosition = .region(
                MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            )

            // ✅ Async safe call
            let addressPublisher = useCase.execute(coordinate: coordinate)
                .receive(on: DispatchQueue.main)

            if let index = self.locations.firstIndex(where: { $0.id == newLocation.id }) {
                addressPublisher
                    .sink { [weak self] location in
                        guard let self = self else { return }
                        self.locations[index] = location
                        self.selectedLocation = location
                    }
                    .store(in: &self.cancellables)
            }

        /*useCase.execute(coordinate: coordinate)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in
                guard let self = self else { return }

                self.mapPosition = .region(
                    MKCoordinateRegion(
                        center: coordinate,
                        span: spanCoordinate
                    )
                )
                withAnimation(.spring()) {
                    self.locations.append(location)
                    self.selectedLocation = location
                }
            }
            .store(in: &cancellables)*/
    }
*/
    func selectLocation(_ location: LocationModel) {
        selectedLocation = location
    }

    func clearSelection() {
        selectedLocation = nil
    }

    // MARK: - Helper
    private func isDuplicate(_ coordinate: CLLocationCoordinate2D) -> Bool {

        let newLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

            return locations.contains { existing in
                let existingLocation = CLLocation(
                    latitude: existing.coordinate.latitude,
                    longitude: existing.coordinate.longitude
                )

                return newLocation.distance(from: existingLocation) < 50 // meters
            }
        // close (~11 meters)
//        locations.contains {
//            abs($0.coordinate.latitude - coordinate.latitude) < 0.0001 &&
//            abs($0.coordinate.longitude - coordinate.longitude) < 0.0001
//        }
    }
}

