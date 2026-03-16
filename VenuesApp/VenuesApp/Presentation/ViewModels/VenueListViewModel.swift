//
//  VenueListViewModel.swift
//  VenuesApp
//
//

import Combine
import Foundation

final class VenueListViewModel: ObservableObject {

    @Published var venuesList: [LocalResult] = []
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
            .receive(on: DispatchQueue.main)
            .sink{  [weak self] completion in

                guard let self = self else { return }
                self.isLoading = false

                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }

            } receiveValue: { [weak self] venues in

                guard let self = self else { return }

                if venues.localResults.isEmpty {
                    self.venuesList = VenueMockData.getVenuesList()
                } else {
                    self.venuesList = venues.localResults
                }

            }
            .store(in: &cancellables)
    }
}
