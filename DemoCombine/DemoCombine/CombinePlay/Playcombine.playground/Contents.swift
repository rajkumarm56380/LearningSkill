import Combine
import Foundation

var x : Int = nil


// Custom Publisher emitting integers from 1 to 5
class CustomIntPublisher: Publisher {
    typealias Output = Int
    typealias Failure = Never

    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = IntSequenceSubscription(subscriber: AnySubscriber(subscriber))
        subscriber.receive(subscription: subscription)
    }
}

// A simple Subscription that emits 1...5 upon demand
final class IntSequenceSubscription: Subscription {
    private var subscriber: AnySubscriber<Int, Never>?
    private var current = 1
    private let end = 5
    private var isCancelled = false

    init(subscriber: AnySubscriber<Int, Never>) {
        self.subscriber = subscriber
    }

    func request(_ demand: Subscribers.Demand) {
        guard !isCancelled, var remaining = Optional(demand) else { return }
        // Emit up to requested demand, or until we finish the sequence
        while remaining > .none, current <= end, !isCancelled {
            let next = current
            current += 1
            let additional = subscriber?.receive(next) ?? .none
            // Accumulate additional demand requested by downstream
            remaining += additional
            remaining -= .max(1)
        }
        if current > end, !isCancelled {
            subscriber?.receive(completion: .finished)
            subscriber = nil
        }
    }

    func cancel() {
        isCancelled = true
        subscriber = nil
    }
}

// Custom Subscriber that transforms and prints the received integers
class CustomIntSubscriber: Subscriber {
    typealias Input = Int
    typealias Failure = Never

    private let subscriber: AnySubscriber<Int, Never>

    init<S: Subscriber>(subscriber: S) where S.Input == Int, S.Failure == Never {
        self.subscriber = AnySubscriber(subscriber)
    }

    func receive(subscription: Subscription) {
        subscription.request(.max(5))
    }

    func receive(_ input: Int) -> Subscribers.Demand {
        let transformed = input * 10
        print("CustomIntSubscriber received transformed value: \(transformed)")
        return .none
    }

    func receive(completion: Subscribers.Completion<Never>) {
        print("CustomIntSubscriber completed with: \(completion)")
    }
}

// Example usage
let customPublisher = CustomIntPublisher()

// Option A: Use our custom transforming subscriber
let customSubscriber = CustomIntSubscriber(subscriber: Subscribers.Sink<Int, Never>(receiveCompletion: { completion in
    print("Sink completion: \(completion)")
}, receiveValue: { value in
    print("Sink received value: \(value)")
}))
customPublisher.subscribe(customSubscriber)
// Option B: Or simply use Combine's built-in sink directly
let cancellable = customPublisher
    .map { $0 * 2 }
    .sink(receiveCompletion: { completion in
        print("Built-in sink completion: \(completion)")
    }, receiveValue: { value in
        print("Built-in sink received value: \(value)")
    })

