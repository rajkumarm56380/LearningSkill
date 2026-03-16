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

    @Published var region =
    MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    @Published var locations: [LocationModel] = []
    @Published var selectedLocation: LocationModel?

    private let locationService = LocationService()
    private let useCase: GetLocationDetailsUseCase
    private var cancellables = Set<AnyCancellable>()

    init(useCase: GetLocationDetailsUseCase) {
        self.useCase = useCase
        bindLocation()
    }

    private func bindLocation() {

        locationService.locationPublisher
            .sink { [weak self] coordinate in
                self?.region.center = coordinate
                self?.addPin(coordinate)
            }
            .store(in: &cancellables)
    }

    func getCurrentLocation() {
        locationService.requestLocation()
    }

    func addPin(_ coordinate: CLLocationCoordinate2D) {

        useCase.execute(coordinate: coordinate)
            .sink { [weak self] location in
                self?.locations.append(location)
            }
            .store(in: &cancellables)
    }
}
