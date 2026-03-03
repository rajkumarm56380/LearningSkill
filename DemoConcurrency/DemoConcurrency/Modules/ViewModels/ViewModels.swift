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
}


