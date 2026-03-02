//
//  ViewModels.swift
//  DemoConcurrency
//
//  Created by Apple on 02/03/26.
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
}


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
