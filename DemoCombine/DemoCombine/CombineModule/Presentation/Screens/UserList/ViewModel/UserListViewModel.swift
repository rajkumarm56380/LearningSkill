//
//  UserListViewModel.swift
//  DemoCombine
//
//  Created by Apple on 02/03/26.
//

import Foundation
import Combine

@MainActor
final class UserListViewModel: ObservableObject {

    // MARK: - Published State

    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Dependencies

    private let fetchUsersUseCase: FetchUsersUseCase

    // MARK: - Memory Management

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    init(fetchUsersUseCase: FetchUsersUseCase) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }

    // MARK: - Public Methods

    func fetchUsers() {
        isLoading = true
        errorMessage = nil

        fetchUsersUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false

                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] users in
                    self?.users = users
                }
            )
            .store(in: &cancellables)
    }
}
