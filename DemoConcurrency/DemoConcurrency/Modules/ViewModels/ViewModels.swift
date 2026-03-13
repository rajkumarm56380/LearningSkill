//
//  ViewModels.swift
//  DemoConcurrency
//
//  Created by user on 02/03/26.
// https://jsonplaceholder.typicode.com

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

    func decrement() {
        counter -= 1
    }

    // Simulate async work
    func fetch(_ name: String, delay: UInt64) async -> String {
        print("Name :- \(name) : START")
        try? await Task.sleep(nanoseconds: delay) // prevent network latency
        print("Task: \(name) : Done!")
        return "Task \(name) loaded"
    }

    
    func fetchMessage() async -> String {
        print("Sending request to server....")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print("Response Received")
        return "User Profile loaded"
    }
    
}


