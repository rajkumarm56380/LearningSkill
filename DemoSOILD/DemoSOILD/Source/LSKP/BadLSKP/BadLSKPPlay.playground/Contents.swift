import UIKit

class Operators {
    func add(num1: Int, num2: Int) -> Int{
        return num1 + num2
    }

    func sub(num1: Int, num2: Int) -> Int{
        return num1 - num2
    }
}

class Calculator: Operators {
    override func add(num1: Int, num2: Int) -> Int {
        return num1 * num2
    }

    override func sub(num1: Int, num2: Int) -> Int {
        return num1 + num2
    }
}


let add = Operators()
print(add.add(num1: 5, num2: 5)) // cool works -> 10

let calc = Calculator()
print(calc.add(num1: 5, num2: 5)) // not working... why? The user is angry. -> 25


class RectangleWithoutLiskov {
    var width: Double = 0
    var length: Double = 0
    var area: Double {
        return width * length
    }
}

class SquareWithoutLiskov: RectangleWithoutLiskov {
    override var width: Double {
        didSet {
            length = width
        }
    }
    override var area: Double {
        return pow(width, 2)
    }
}

let rectangleWithoutLiskov = RectangleWithoutLiskov()
rectangleWithoutLiskov.width = 5
rectangleWithoutLiskov.length = 5
rectangleWithoutLiskov.area

let squareWithoutLiskov = SquareWithoutLiskov()
squareWithoutLiskov.width = 3
squareWithoutLiskov.area


class Bird {
    func fly() {
        print("Flying")
    }
}

class Penguin: Bird {
    override func fly() {
        // Penguins cannot fly!
        fatalError("Penguins cannot fly")
    }
}


class Vehicle {
    func startEngine() {
        print("🚗 Engine started!")
    }

    func drive() {
        print("🚗 Driving...")
    }
}

class Car: Vehicle {
    override func startEngine() {
        print("🚗 Car engine started!")
    }

    override func drive() {
        print("🚗 Car is driving...")
    }
}

class Bicycle: Vehicle {
    override func startEngine() {
        fatalError("❌ Bicycles don’t have engines!") // ❌ Breaks LSP
    }

    override func drive() {
        print("🚴‍♂️ Pedaling the bicycle...")
    }
}


func testDrive(vehicle: Vehicle) {
   vehicle.startEngine() // ❌ Will crash if `vehicle` is a Bicycle!
   vehicle.drive()
}

let myCar = Car()
testDrive(vehicle: myCar)
// ✅ "🚗 Car engine started!"
// ✅ "🚗 Car is driving..."

let myBike = Bicycle()
testDrive(vehicle: myBike)
// ❌ CRASH! "fatalError: Bicycles don’t have engines!"


