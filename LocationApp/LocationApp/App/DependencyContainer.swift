//
//  DependencyContainer.swift
//  LocationApp
//
//

class DependencyContainer {

    @MainActor static func makeMapViewModel() -> MapViewModel {
        let repo = LocationRepository()
        let useCase = GetLocationDetailsUseCase(repository: repo)
        return MapViewModel(useCase: useCase)
    }
}
