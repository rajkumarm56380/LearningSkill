//
//  DependencyContainer.swift
//  LocationApp
//
//

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
    @MainActor func makeMapViewModel() -> MapViewModel {
        MapViewModel(
            useCase: getLocationDetailsUseCase
        )
    }
}
