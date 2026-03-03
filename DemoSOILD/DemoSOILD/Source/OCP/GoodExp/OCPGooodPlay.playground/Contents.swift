import UIKit
import Foundation

protocol Shape {
    func calculateArea() -> Double
}

class RectangleWithOCP: Shape {
    var width: Double
    var height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    func calculateArea() -> Double {
        return (width * height)
    }
}

class Triangle: Shape {
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

class CalculateAreaManager {
    func area(shape: Shape) -> Double {
        return shape.calculateArea()
    }
}

// Usage
let objmanager = CalculateAreaManager()
let objrectangleShape = RectangleWithOCP(width: 10, height: 5)
let objtriangleShape = Triangle(base: 5, height: 10)

let objAreaOfRectangle = objmanager.area(shape: objrectangleShape)
let objAreaOfTriangle = objmanager.area(shape: objtriangleShape)

// print(objAreaOfRectangle)
// print(objAreaOfTriangle)

protocol PlayerInfo {
    func getPlayerInfo() -> String
}

class BatsmanOnly: PlayerInfo {
    private var name: String

    init(name: String) {
        self.name = name
    }

    func getPlayerInfo() -> String {
        return "Name: \(name)"
    }
}

class BowlerOnly: PlayerInfo {
    private var name: String

    init(name: String) {
        self.name = name
    }

    func getPlayerInfo() -> String {
        return "Name: \(name)"
    }

}

class Manager {
    func getPlayerDetails(player: PlayerInfo) -> String {
        return player.getPlayerInfo()
    }
}

let managerObj = Manager()
let playerBat = BatsmanOnly(name: "Rajkumar")
let playerBowl = BowlerOnly(name: "Dharma")

let obj1 = managerObj.getPlayerDetails(player: playerBat)
let obj2 = managerObj.getPlayerDetails(player: playerBowl)


extension Int {
    func multipleInt(of number: Int) -> Int {
        return self * number
    }

    func isNegative() -> Bool {
        if self < 0 {
            return true
        }
        return false
    }
    
    func addInt(_ number: Int) -> Int {
        return self + number
    }
}


let intValue = 99

print(intValue.multipleInt(of: 10)) // 990
print(intValue.isNegative()) // false
print(intValue.addInt(2))

protocol Info {
    func animalInfo() -> String
}

class Cat: Info {
    var name: String

    init(name: String) {
        self.name = name
    }

    func animalInfo() -> String {
        return "I am Cat and name is \(self.name)"
    }
}

class Fish: Info {
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
        let animalsInfo: [Info] = [
                                Cat(name: "Luna"),
                                Cat(name: "Tina"),
                                Cat(name: "Moon"),
                                Fish(name: "Ishxan"),
                                Fish(name: "Karas"),
                                Fish(name: "Sterlec"),
                                Fish(name: "fish")
                            ]

        for info in animalsInfo {
            print(info.animalInfo())
        }
    }
}

let infoOfAnimals = AnimalsInfo()
infoOfAnimals.printData()

class Rectangle: Shape {
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

class AreaCalculator {
    func calculateArea(shape: Shape) -> Double {
        return shape.calculateArea()
    }
}


protocol PaymentMethod {
    func pay(amount: Double)
}

class CreditCardPayment: PaymentMethod {
    func pay(amount: Double) {
        print("💳 Processing Credit Card Payment of $\(amount)")
    }
}

class PayPalPayment: PaymentMethod {
    func pay(amount: Double) {
        print("💰 Processing PayPal Payment of $\(amount)")
    }
}

class ApplePayPayment: PaymentMethod {
    func pay(amount: Double) {
        print("📱 Processing Apple Pay Payment of $\(amount)")
    }
}

class PaymentProcessor {
    private let paymentMethod: PaymentMethod

    init(paymentMethod: PaymentMethod) {
        self.paymentMethod = paymentMethod
    }

    func processPayment(amount: Double) {
        paymentMethod.pay(amount: amount)
    }
}

let creditCardPayment = PaymentProcessor(paymentMethod: CreditCardPayment())
creditCardPayment.processPayment(amount: 100.0)

let payPalPayment = PaymentProcessor(paymentMethod: PayPalPayment())
payPalPayment.processPayment(amount: 50.0)

let applePayPayment = PaymentProcessor(paymentMethod: ApplePayPayment())
applePayPayment.processPayment(amount: 30.0)


