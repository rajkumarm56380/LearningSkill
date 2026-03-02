import UIKit
import Foundation
import Combine

private var cancellables = Set<AnyCancellable>()

let url = URL(string: "https://jsonplaceholder.typicode.com/users/1")!

// Receives values from a publisher.
    let publisher = Combine.Just("Hello")
    publisher
        .sink { value in
            print("Result ==>", value)
        }
        .store(in: &cancellables)
    print("publisher  ==>" , publisher)

// map: Transforms the data emitted by a publisher.

    let mapPublisher = Combine.Just(5)
    mapPublisher
        .map { $0 * 2 } // Emits 10
        .sink { print($0) }
        .store(in: &cancellables)
    print("mapPublisher  ==>" , mapPublisher)

// filter: Filters values based on a condition.

    let publisherFilter = Combine.Just(10)
    publisherFilter
        .filter { $0 > 5 } // Emits 10 if condition is true
        .sink { print($0) }
        .store(in: &cancellables)

    print("publisherFilter  ==>" , publisherFilter)

// merge: Merges two publishers into one stream.
    let publisherMerge = Combine.Just(1)
    let publisher2 = Combine.Just(2)
publisherMerge
        .merge(with: publisher2)
        .sink { print($0) } // Emits 1, then 2
        .store(in: &cancellables)


print("Merges Two Publisher  ==>" , publisherMerge)

// debounce: Waits for a period of silence before emitting the last value.
@MainActor
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

print("demoDebounce  ==>" , demoDebounce())

// combineLatest: Combines the latest values of multiple publishers.
@MainActor
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

print("demoCombineLatest  ==>" , demoCombineLatest())

// Demonstrates sink with completion and value handling.
@MainActor
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

print("demoSinkCompletion  ==>" , demoSinkCompletion())
// No initial value.
// Use:
// Event broadcasting
// Button taps
// Navigation triggers

let subject = PassthroughSubject<String, Never>()
subject.send("Hello")

print("subject  ==>" , subject)
// Keeps latest value.

let subjectCurrent = CurrentValueSubject<Int, Never>(0)

subjectCurrent.send(5)
print(subjectCurrent.value)

print("subjectCurrent  ==>" , subjectCurrent)

struct User: Decodable { let id: Int }

@MainActor
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

print("demoAPI  ==>" , demoAPI())

@MainActor
func callAPI() {
    URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: User.self, decoder: JSONDecoder())
        .sink(receiveCompletion: { _ in }, receiveValue: { user in print(user) })
        .store(in: &cancellables)
}
