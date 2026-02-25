//: [Previous](@previous)

import Foundation
import SwiftUI

func addVal<T: Numeric>(_ aVal: T, _ bVal: T) -> T {
    return aVal + bVal
}

print(addVal(20, 50))

func add<T: Numeric>(_ a: T, _ b: T) -> T {
    return a + b
}

print(add(10, 20))

func compareVal<T: Comparable>(_ aVal: T, _ bVal: T) -> Bool {
    return aVal > bVal
}

print(compareVal(90, 50))

func min<T: Comparable>(_ x: T, _ y: T) -> T {
       return y < x ? y : x
}

print(min(60, 20))

struct StackLists<Element> {
    private var items: [Element] = []
    
    mutating func addItem(_ item: Element) {
        items.append(item)
    }
    
    mutating func popLastItem() -> Element? {
        return items.popLast()
    }
}

var objStack = StackLists<String>()
objStack.addItem("Testing")
objStack.addItem("iOS")
objStack.popLastItem()

var objStackInt = StackLists<Int>()
objStackInt.addItem(60)
objStackInt.addItem(10)
objStackInt.popLastItem()


func findIndex<T: Equatable>(_ values:[T], findValue: T) -> Int? {
    for (index, value) in values.enumerated() {
        if value == findValue {
            return index
        }
    }
    return nil
}

print("Result ==>", findIndex([40,90,20,50,10,5], findValue: 20))

struct MyView: View {
    var body: some View {
        VStack {
            Text("Testing")
            Button("Click Me", action: {
                print("Action Done!")
            })
        }
    }
}

/*
func makeHeaderView(isProUser: Bool) -> some View { // Error: Function declares an opaque return type, but return statements...
    if isProUser {
        return Text("Premium User") // Returns Text
    } else {
        return Image(systemName: "person.circle") // Returns Image
    }
}
print(makeHeaderView(isProUser: true))
*/

var customView: any View = Text("Testing")
customView = Button("Click me", action: {})

protocol Drawable {
    func draw()
}

struct Line: Drawable {
    func draw() { print("Draw Line") }
}

struct Point: Drawable {
    func draw() { print("Draw Point") }
}

// An array holding different concrete types that conform to Drawable
let shapes: [any Drawable] = [Line(), Point(), Line()]

for shape in shapes {
    shape.draw() // Dynamic dispatch is used here
}


extension Array where Element: Equatable {
    func containsAndPrint(_ item: Element) {
        if self.contains(item) {
            print("The array contains the item.")
        }
    }
    
}

let equatableArray = [1, 2, 3]
equatableArray.containsAndPrint(2) // Works

// let nonEquatableArray = [someStruct] // Cannot use containsAndPrint if someStruct is not Equatable

protocol Flyable {
  func fly()
}

class Bird: Flyable {
  func fly() {
    print("I can fly")
  }
}

struct Flight<T: Flyable> {
  let flyingObject: T
}

let flight = Flight(flyingObject: Bird())
flight.flyingObject.fly() // prints "I can fly"

protocol Container {
  associatedtype Item
  var items: [Item] { get set }
  mutating func append(_ item: Item)
  mutating func pop() -> Item
  var count: Int { get }
}

struct Stack<T>: Container {
  var items = [T]()
  mutating func append(_ item: T) {
    items.append(item)
  }
  mutating func pop() -> T {
    return items.removeLast()
  }
  var count: Int {
    return items.count
  }
}

extension Container {
    // Method only available when Item is Int
    func average() -> Double where Item == Int {
        // ... implementation to calculate average of Ints ...
        return 0.0
    }
}

func popAllAndTestMatch<C1: Container, C2: Container>(
  _ someContainer: inout C1,
  _ anotherContainer: inout C2
) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {
  if someContainer.count != anotherContainer.count {
    return false
  }
  for _ in 0..<someContainer.count {
    if someContainer.pop() != anotherContainer.pop() {
      return false
    }
  }
  return true
}

var stackOfStrings1 = Stack<String>()
stackOfStrings1.append("uno")
stackOfStrings1.append("dos")
stackOfStrings1.append("tres")

var stackOfStrings2 = Stack<String>()
stackOfStrings2.append("uno")
stackOfStrings2.append("dos")
stackOfStrings2.append("tres")

if popAllAndTestMatch(&stackOfStrings1, &stackOfStrings2) {
  print("All items match.")
} else {
  print("Not all items match.")
}
// Output: All items match


// In Swift, you can use generic subscripts to define a subscript that can be used with any type of collection.
   // A generic subscript is defined by using the subscript keyword, followed by a generic parameter list and a return type.
struct Stacks<Element> {
  var items = [Element]()
  mutating func push(_ item: Element) {
    items.append(item)
  }

  mutating func pop() -> Element? {
    guard !items.isEmpty else {
      return nil
    }
    return items.removeLast()
  }

  subscript<Indices: Sequence>(
    indices: Indices
  ) -> [Element]
  where Indices.Iterator.Element == Int {
    var result = [Element]()
    for index in indices {
      guard index < items.count else {
        continue
      }
      result.append(items[index])
    }
    return result
  }
}

var stack = Stacks<String>()
stack.push("uno")
stack.push("dos")
stack.push("tres")

print(stack[[0,2]]) // Prints ["uno", "tres"]









