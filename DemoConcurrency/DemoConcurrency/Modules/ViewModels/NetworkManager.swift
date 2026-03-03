//
//  NetworkManager.swift
//  DemoConcurrency
//
//  Created by user on 02/03/26.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    private var cancellables = Set<AnyCancellable>()

    func fetchUser() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users/1")!

        // Create a publisher
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data } // Extract the data from the tuple (data, response)
            .decode(type: User.self, decoder: JSONDecoder()) // Decode the data to a User object
            .receive(on: DispatchQueue.main) // Switch to the main thread for UI updates
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] user in
                self?.user = user
                self?.isLoading = false
            })
            .store(in: &cancellables)

        isLoading = true
    }
}

