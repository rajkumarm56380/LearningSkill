import UIKit

// Generic Functions
 // It can work with any type

print("Generic Functions")
func swapValue<T>(_ aVal: inout T, _ bVal: inout T) {
    let temp = aVal
    aVal = bVal
    bVal = temp
}
 
var valA = 20
var valB = 50
print("SwapValue =",swapValue(&valA, &valB))
print(String(repeating: "-", count: 50))

func printString<T:CustomStringConvertible>(_ aVal: [T]) {
    aVal.forEach{ print($0)}
}

print(printString(["Raj","Kumar","Mahalingam","iOS"]))
print(String(repeating: "-", count: 50))

print("Generic Struct")

struct Stack<Element> {
    var elementList: [Element]
    
    mutating func addElement(_ element: Element) {
        elementList.append(element)
    }
    mutating func getElement() -> Element? {
        elementList.last
    }
}


var objInt = Stack(elementList:[12,14,15,16])
var objString = Stack<String>(elementList:["Rajkumar","Mahalingam","iOS","Test"])
      
print(objInt.getElement())
print(objString.getElement())

print(String(repeating: "-", count: 50))

print("Generic Class")

class GenericClass<Element> {
    
    private var elementList: [Element] = []

    func addElement(_ element: Element) {
        elementList.append(element)
    }
    
    func getList() -> [Element] {
        elementList
    }
}

print(String(repeating: "-", count: 50))
