//
//  DependencyContainer.swift
//  LocationApp
//
//

import Foundation
import CoreLocation

final class DependencyContainer {

    // MARK: - Services
    lazy var geocoderService: GeocoderServiceProtocol = GeocoderService()
    lazy var locationService = LocationService()

    // MARK: - Repository
    lazy var locationRepository: LocationRepositoryProtocol =
        LocationRepository(geocoder: geocoderService)

    // MARK: - UseCases
    lazy var getLocationDetailsUseCase =
        GetLocationDetailsUseCase(repository: locationRepository)

    // MARK: - ViewModels
    @MainActor
     func makeMapViewModel() -> MapViewModel {
        if ProcessInfo.processInfo.arguments.contains("UI_TEST_MODE") {

            let viewModel = MapViewModel(
                   locationService: MockLocationService(),
                   useCase: getLocationDetailsUseCase
               )

            viewModel.locations = [
                   LocationModel(coordinate: CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946), name: "Test Place A", address: "Testing Address A"),
                   LocationModel(coordinate: CLLocationCoordinate2D(latitude: 12.9720, longitude: 77.5950), name: "Test Place B", address: "Testing Address B"),
                   LocationModel(coordinate: CLLocationCoordinate2D(latitude: 12.9730, longitude: 77.5960), name: "Test Place C", address: "Testing Address C")
               ]

               return viewModel
        } else {
            return MapViewModel(
                locationService: locationService,
                useCase: getLocationDetailsUseCase
            )
        }
    }
}
