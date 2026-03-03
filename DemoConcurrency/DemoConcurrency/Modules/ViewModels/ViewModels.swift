//
//  ViewModels.swift
//  DemoConcurrency
//
//  Created by user on 02/03/26.
//

import Foundation

import SwiftUI
import Combine

class ViewModel: ObservableObject {
    @Published var counter = 0 // Publisher
    private var cancellables = Set<AnyCancellable>()
    init() {
        // Setup a subscription
        $counter
            .sink { newValue in
                print("Counter changed to \(newValue)")
            }
            .store(in: &cancellables)
    }
    func increment() {
        counter += 1
    }
    
    func fetchUser() async throws -> String {
        try await Task.sleep(nanoseconds: 1)
        return "Testing"
    }
    
    func loadData() async throws {
        let data1 = try await fetchUser()
        let data2 = try await fetchUser()
        let data3 = try await fetchUser()
        
        print("Data1 ==> \(data1), Data2 ==> \(data2), Data3 ==> \(data3)")
    }
    
    func fetchMessage() async -> String {
        return "Fetching Message ..."
    }
    
    func loadTask() {
        Task {
            let result = await fetchMessage()
            print("result ==> \(result)")
        }
    }
    
    func fetchUsers() async throws -> [User] {
        let url = URL(string: "https://api.example.com/users")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([User].self, from: data)
    }
    
    func loadUsers() {
        Task {
            do {
                let users = try await fetchUsers()
                print(users)
            } catch {
                print(error)
            }
        }
    }
    
    func fetchAll() async throws -> [User] {
        try await withThrowingTaskGroup(of: User.self) { group in

            for id in 1...5 {
                group.addTask {
                    try await fetchUser(id: id)
                }
            }

            var users: [User] = []

            for try await user in group {
                users.append(user)
            }

            return users
        }
    }}

/*
// map: Transforms the data emitted by a publisher.
let publishers = Just(5)
publishers
    .map { $0 * 2 } // Emits 10
    .sink { print($0) }
// filter: Filters values based on a condition.

let publisherss = Just(10)
publisherss
    .filter { $0 > 5 } // Emits 10 if condition is true
    .sink { print($0) }

// merge: Merges two publishers into one stream.
let publisher1 = Just(1)
let publisher2 = Just(2)
publisher1
    .merge(with: publisher2)
    .sink { print($0) } // Emits 1, then 2
// debounce: Waits for a period of silence before emitting the last value.
let publisher = PassthroughSubject<String, Never>()

publisher
    .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
    .sink { print($0) }
// combineLatest: Combines the latest values of multiple publishers.
let publisher1 = PassthroughSubject<Int, Never>()
let publisher2 = PassthroughSubject<String, Never>()
publisher1
    .combineLatest(publisher2)
    .sink { print($0, $1) }
*/
