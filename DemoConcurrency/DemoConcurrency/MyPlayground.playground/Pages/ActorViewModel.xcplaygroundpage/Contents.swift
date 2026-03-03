//: [Previous](@previous)

import Foundation

actor CounterVal {
    var counter = 0

    func increment() {
        counter += 1
    }

    func getValue() -> Int {
        return counter
    }
}

func callCounter() {
    let counter = CounterVal()
    Task {
        await counter.increment()
        print("Counter value: \(await counter.getValue())")
    }

}

callCounter()
