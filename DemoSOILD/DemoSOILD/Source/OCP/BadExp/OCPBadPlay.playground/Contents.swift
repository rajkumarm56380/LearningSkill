import UIKit
import Foundation

// Classes without Open-Closed Principle (OCP)

class RectangleWithoutOCP {
    var width: Double
    var height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    func calculateArea() -> Double {
        return width * height
    }
}

class TriangleWithoutOCP {
    var base: Double
    var height: Double

    init(base: Double, height: Double) {
        self.base = base
        self.height = height
    }

    func calculateArea() -> Double {
        return 0.5 * base * height
    }
}

class CalculateAreaManagerWithoutOCP {
    func area(shape: RectangleWithoutOCP) -> Double {
        return shape.calculateArea()
    }

    func area(shape: TriangleWithoutOCP) -> Double {
        return shape.calculateArea()
    }
}

// Usage
let manager = CalculateAreaManagerWithoutOCP()
let rectangleShape = RectangleWithoutOCP(width: 10, height: 5)
let triangleShape = TriangleWithoutOCP(base: 5, height: 10)

let areaOfRectangle = manager.area(shape: rectangleShape)
let areaOfTriangle = manager.area(shape: triangleShape)

class Cat {
    var name: String

    init(name: String) {
        self.name = name
    }

    func animalInfo() -> String {
        return "I am Cat and name is \(self.name)"
    }
}

class Fish {
    var name: String

    init(name: String) {
        self.name = name
    }

    func animalInfo() -> String {
        return "I am fish and name is \(self.name)"
    }
}

class AnimalsInfo {
    func printData() {
        let cats = [Cat(name: "Luna"), Cat(name: "Tina"), Cat(name: "Moon")]

        for cat in cats {
            print(cat.animalInfo())
        }

        let fishes = [Fish(name: "Ishxan"), Fish(name: "Karas"), Fish(name: "Sterlec"), Fish(name: "fish")]
        for fish in fishes {
            print(fish.animalInfo())
        }
    }
}

let infoOfAnimals = AnimalsInfo()
infoOfAnimals.printData()

class Rectangle {
    var width: Double
    var height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

class AreaCalculator {
    func calculateArea(shape: Any) -> Double {
        if let rectangle = shape as? Rectangle {
            return rectangle.width * rectangle.height
        }
        return 0
    }
}


class PaymentProcessor {
    func processPayment(amount: Double, method: String) {
        switch method {
        case "CreditCard":
            print("Processing Credit Card Payment of $\(amount)")
        case "PayPal":
            print("Processing PayPal Payment of $\(amount)")
        case "ApplePay":
            print("Processing Apple Pay Payment of $\(amount)")
        default:
            print("Unsupported payment method")
        }
    }
}

