//
//  UserSearchViewModel.swift
//  DemoCombine
//
//  Created by user on 02/03/26.
//

import Foundation
import Combine
import SwiftUI

final class UserSearchViewModel: ObservableObject {

    // Input
    @Published var searchText: String = ""

    // Output
    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let useCase: SearchUsersUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(useCase: SearchUsersUseCaseProtocol) {
        self.useCase = useCase
        bind()
    }

    private func bind() {

        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = true
                self?.errorMessage = nil
            })
            .flatMap { [weak self] query -> AnyPublisher<[User], Never> in
                guard let self = self else {
                    return Just([]).eraseToAnyPublisher()
                }

                return self.useCase.execute(query: query)
                    .catch { [weak self] error -> Just<[User]> in
                        self?.errorMessage = error.localizedDescription
                        return Just([])
                    }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                self?.isLoading = false
                self?.users = users
            }
            .store(in: &cancellables)
    }
}
