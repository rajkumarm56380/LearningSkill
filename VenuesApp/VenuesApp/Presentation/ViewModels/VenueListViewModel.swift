//
//  VenueListViewModel.swift
//  VenuesApp
//
//

import Combine

final class VenueListViewModel: ObservableObject {

    @Published var veneusList: [Venue] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    private let useCase: GetNearbyVenuesUseCaseProtocol

    init(useCase: GetNearbyVenuesUseCaseProtocol) {
        self.useCase = useCase
    }

    func loadVenues() {
        isLoading = true
        useCase.execute()
            .sink{ completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] venues in
                if venues.isEmpty {
                    self?.veneusList = VenueMockData.loadVenues()
                } else {
                    self?.veneusList = venues
                }
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
}
