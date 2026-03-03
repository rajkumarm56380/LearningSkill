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
        return num1 + num2
    }

    override func sub(num1: Int, num2: Int) -> Int {
        return num1 - num2
    }

    func add(num1: Int, num2: Int, num3: Int) -> Int{
        return num1 + num2 + num3
    }
}

let add = Operators()
print(add.add(num1: 5, num2: 5)) // cool works -> 10

let calc = Calculator()
print(calc.add(num1: 5, num2: 5)) // cool works -> 10

// also added a new function

print(calc.add(num1: 2, num2: 5, num3: 6))

protocol ShapeLiskov {
    var area: Double { get }
}

class RectangleLiskov: ShapeLiskov {
    var width: Double = 0
    var length: Double = 0

    var area: Double {
        return width * length
    }
}

class SquareLiskov: ShapeLiskov {
    var width: Double = 0

    var area: Double {
        return pow(width, 2)
    }
}

// Usage
let objRectangle = RectangleLiskov()
objRectangle.length = 5
objRectangle.width = 5
print("ObjRectangle ==> ",objRectangle.area)  // Output: 25.0

let objSquare = SquareLiskov()
objSquare.width = 6
print("objSquare ==> ",objSquare.area)     // Output: 36.0

protocol Bird {
    func move()
}

class FlyingBird: Bird {
    func move() {
        fly()
    }

    func fly() {
        print("Flying")
    }
}

class Penguin: Bird {
    func move() {
        swim()
    }

    func swim() {
        print("Swimming")
    }
}


protocol Drivable {
    func drive()
}

protocol MotorizedVehicle: Drivable {
    func startEngine()
}


class Car: MotorizedVehicle {
    func startEngine() {
        print("🚗 Car engine started!")
    }

    func drive() {
        print("🚗 Car is driving...")
    }
}


class Bicycle: Drivable {
    func drive() {
        print("🚴‍♂️ Pedaling the bicycle...")
    }
}


func testDrive(vehicle: Drivable) {
    vehicle.drive() // ✅ No more startEngine() crashes!
}

let myCar = Car()
testDrive(vehicle: myCar)
// ✅ "🚗 Car is driving..."

let myBike = Bicycle()
testDrive(vehicle: myBike)
// ✅ "🚴‍♂️ Pedaling the bicycle..."


