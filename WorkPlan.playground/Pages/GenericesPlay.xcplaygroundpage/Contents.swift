import SwiftUI

func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var x = 10, y = 20

print("swapValues")
swapValues(&x, &y)
print(x, y)  // ✅ Output: 20 10

var str1 = "Hello", str2 = "Swift"
swapValues(&str1, &str2)
print(str1, str2)  // ✅ Output: Swift Hello
print(String(repeating: "-", count: 50))

func add<T: Numeric>(_ a: T, _ b: T) -> T {
    return a + b
}

print(add(10, 20))       // ✅ Output: 30
print(add(5.5, 2.3))     // ✅ Output: 7.8
// print(add("Hello", "Swift")) ❌ Error: String does not conform to Numeric
print(String(repeating: "-", count: 50))


// This function only works for types that can be compared using '=='
func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind { return index }
    }
    return nil
}

print("findIndex ==> ",findIndex(of: 50, in: [30,10,60,30,90,50,20]) ?? [0])
print(String(repeating: "-", count: 50))

func compare<T: Equatable>(_ a: T, _ b: T) -> Bool {
    return a == b
}

print("compare ==> ",compare(50,90))
print(String(repeating: "-", count: 50))

func findSecondLargest(in numbers: [Int]) -> Int? {
    // We need at least two elements
    guard numbers.count >= 2 else { return nil }

    var max = Int.min
    var secondMax = Int.min

    for number in numbers {
        if number > max {
            secondMax = max
            max = number
        } else if number > secondMax && number != max {
            secondMax = number
        }
    }

    // If secondMax is still Int.min, it means no distinct second largest exists
    return secondMax == Int.min ? nil : secondMax
}

let result = findSecondLargest(in: [10, 20, 4, 45, 99, 99]) // Returns 45
print("findSecondLargest ==> ",result ?? 0)
print(String(repeating: "-", count: 50))

extension Collection where Element: Comparable {
    func secondLargest() -> Element? {
        guard count >= 2 else { return nil }

        var largest: Element?
        var secondLargest: Element?

        for item in self {
            if largest == nil || item > largest! {
                secondLargest = largest
                largest = item
            } else if item < largest!, (secondLargest == nil || item > secondLargest!) {
                secondLargest = item
            }
        }

        return secondLargest
    }
}

// Usage
let doubles = [12.5, 30.1, 5.5, 30.1, 28.0]
print(doubles.secondLargest() ?? "Not found") // 28.0

let numbers = [10, 20, 4, 45, 99, 99]
// 1. Convert to Set to remove duplicates
// 2. Sort in descending order
// 3. Drop the first element and take the next
let second = Set(numbers).sorted(by: >).dropFirst().first
print(second ?? "None") // 45
print(String(repeating: "-", count: 50))

struct Box<T> {
    let value: T
}

let intBox = Box(value: 5)
let stringBox = Box(value: "Hello")

print("intBox ==> ", intBox)
print("stringBox ==> ", stringBox)

print(String(repeating: "-", count: 50))

struct Stack<T> {
    private var elements: [T] = []

    mutating func push(_ value: T) {
        elements.append(value)
    }

    mutating func pop() -> T? {
        return elements.popLast()
    }

    func peek() -> T? {
        return elements.last
    }
}

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
print(intStack.pop()!)  // ✅ Output: 2

var stringStack = Stack<String>()
stringStack.push("Swift")
stringStack.push("Generics")
stringStack.peek()
print(stringStack.pop()!)  // ✅ Output: Generics
print(String(repeating: "-", count: 50))

protocol ContainerProtocol {
    associatedtype Item
    mutating func add(_ item: Item)
    func getItems() -> [Item]
}

struct IntContainer: ContainerProtocol {
    var items: [Int] = []

    mutating func add(_ item: Int) {
        items.append(item)
    }

    mutating func itemLast() -> Int? {
        items.popLast()
    }
    func getItems() -> [Int] {
        return items
    }
}

var objNumbers = IntContainer()
objNumbers.add(5)
objNumbers.add(10)
objNumbers.itemLast()
print("IntContainer",objNumbers.getItems())  // ✅ Output: [5, 10]

protocol Appendable {
  associatedtype Element
  var collection: [Element] { get set }
  func append(_ element: Element)
}

class CustomGenericArray<T>: Appendable {
  var collection = [T]()

  func append(_ element: T) {
    collection.append(element)
  }
}

print(String(repeating: "-", count: 50))

class StringArray: Appendable {
    typealias Item = String
    var collection: [String] = []
    func append(_ item: String) {
        collection.append(item)
    }
}

class NumberArray: Appendable {
  var collection = [Int]()
  
  func append(_ element: Int) {
    collection.append(element)
  }
}

var stringArray = StringArray()
stringArray.append("Hello")
stringArray.append("World")
print("stringArray", stringArray.collection)

var numberArray = NumberArray()
numberArray.append(1)
numberArray.append(2)
print("numberArray", numberArray.collection)

print(String(repeating: "-", count: 50))

var genericArrayString = CustomGenericArray<String>()
genericArrayString.append("Rajkumar")
genericArrayString.append("Mahalingam")
print("genericArrayString", genericArrayString.collection)

var genericArrayInt = CustomGenericArray<Int>()
genericArrayInt.append(90)
genericArrayInt.append(10)
print("genericArrayInt", genericArrayInt.collection)
print(String(repeating: "-", count: 50))

print("Generic View")

struct CustomList<Content: View>: View {
    let content: () -> Content

    var body: some View {
        VStack {
            content()
        }
    }
}

CustomList {
    Text("Hello")
}

struct StruckView<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        VStack {
            content()
        }
    }
}

StruckView {
    Button(action: {
        print("Click action")
    }) {
        HStack {
            Image(systemName:"star.fill")
                .foregroundColor(.yellow)
            Text("Click")
                .font(.title)
        }
    }
}
struct Container<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
    }
}

protocol Endpoint {
    associatedtype Response: Decodable
    var path: String { get }
}

protocol NetworkService {
    func request<E: Endpoint>(_ endpoint: E) async throws -> E.Response
}


actor SafeStore<T> {
    private var value: T

    init(_ value: T) {
        self.value = value
    }

    func get() -> T {
        value
    }

    func update(_ newValue: T) {
        value = newValue
    }
}

final class ThreadSafeBox<T> {
    private var value: T
    private let queue = DispatchQueue(label: "thread.safe.box")

    init(_ value: T) {
        self.value = value
    }

    func get() -> T {
        queue.sync { value }
    }

    func set(_ newValue: T) {
        queue.sync { value = newValue }
    }
}




