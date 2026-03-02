//
//  CombineViewModels.swift
//  DemoCombine
//
//  Created by user on 26/02/26.
//

import Foundation
import Combine

final class CombineViewModels: ObservableObject {

    private var cancellables = Set<AnyCancellable>()

    let url = URL(string: "https://jsonplaceholder.typicode.com/users/1")!

    // Receives values from a publisher.
    func samplePublisher() {
        let publisher = Combine.Just("Hello")
        publisher
            .sink { value in
                print("Result ==>", value)
            }
            .store(in: &cancellables)
    }

    // map: Transforms the data emitted by a publisher.
    func demoMap() {
        let publisher = Combine.Just(5)
        publisher
            .map { $0 * 2 } // Emits 10
            .sink { print($0) }
            .store(in: &cancellables)
    }

    // filter: Filters values based on a condition.
    func demoFilter() {
        let publisher = Combine.Just(10)
        publisher
            .filter { $0 > 5 } // Emits 10 if condition is true
            .sink { print($0) }
            .store(in: &cancellables)
    }

    // merge: Merges two publishers into one stream.
    func demoMerge() {
        let publisher1 = Combine.Just(1)
        let publisher2 = Combine.Just(2)
        publisher1
            .merge(with: publisher2)
            .sink { print($0) } // Emits 1, then 2
            .store(in: &cancellables)
    }

    // debounce: Waits for a period of silence before emitting the last value.
    func demoDebounce() {
        let subject = PassthroughSubject<String, Never>()
        subject
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { print($0) }
            .store(in: &cancellables)

        // Example emissions
        subject.send("A")
        subject.send("B")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            subject.send("C") // Only "C" will print after debounce window
        }
    }

    // combineLatest: Combines the latest values of multiple publishers.
    func demoCombineLatest() {
        let publisherA = PassthroughSubject<Int, Never>()
        let publisherB = PassthroughSubject<String, Never>()

        publisherA
            .combineLatest(publisherB)
            .sink { intVal, strVal in
                print(intVal, strVal)
            }
            .store(in: &cancellables)

        // Example emissions
        publisherA.send(1)
        publisherB.send("X") // prints: 1 X
        publisherA.send(2)    // prints: 2 X
        publisherB.send("Y") // prints: 2 Y
    }

    // Demonstrates sink with completion and value handling.
    func demoSinkCompletion() {
        let publisher = Combine.Just("Done")
        publisher
            .setFailureType(to: Error.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { value in
                print("Received value: \(value)")
            })
            .store(in: &cancellables)
    }

    //struct User: Decodable { let id: Int }
    func demoAPI () {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: User.self, decoder: JSONDecoder())
            .sink(receiveCompletion:  { _ in

            }, receiveValue: { user in
                print("User ==> \(user)")
            })
            .store(in: &cancellables)
    }
    // NOTE: Examples requiring external types/objects are intentionally omitted or commented.
    // For instance, assign(to:on:) requires a concrete reference type and key path:
    //

//     class SomeObject { var count: Int = 0 }
//     let obj = SomeObject()
//     Just(3)
//        .assign(to: \SomeObject.count, on: obj)
//        .store(in: &cancellables)

    // Networking examples need a concrete dataTaskPublisher and a decodable type:

    func callAPI() {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: User.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { _ in }, receiveValue: { user in print(user) })
            .store(in: &cancellables)
    }

    func deAPI() {
        // Example: Debounce text input
        let searchSubject = PassthroughSubject<String, Never>()
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { searchText in
                // Perform API call
            }
            .store(in: &cancellables)

    }


}
