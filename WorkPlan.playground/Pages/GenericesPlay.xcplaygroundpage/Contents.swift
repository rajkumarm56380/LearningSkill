protocol Appendable {
  associatedtype Element
  var collection: [Element] { get set }
  mutating func append(_ element: Element)
}

class CustomGenericArray<T>: Appendable {
  var collection = [T]()

  func append(_ element: T) {
    collection.append(element)
  }
}

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
