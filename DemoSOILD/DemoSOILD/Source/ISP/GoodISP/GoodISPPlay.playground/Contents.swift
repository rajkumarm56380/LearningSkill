import UIKit

protocol Flyable {
    func fly()
}

protocol Swimmable {
    func swim()
}

protocol Feedable {
    func eat()
}

class Flamingo: Flyable, Swimmable, Feedable  {
    func eat() {
        print("I can eat")
    }

    func fly() {
        print("I can fly")
    }

    func swim() {
        print("I can swim")
    }
}

class Dogs: Feedable {
    func eat() {
        print("I can eat")
    }
}


protocol OnlySubstitute {
    func doFielding()
}

protocol BatsmanOnly: OnlySubstitute {
    func doBatting()
    func doFielding()
}

protocol BowlerOnly: OnlySubstitute {
    func doBowling()
    func doFielding()
}

protocol AllRounderOnly: BatsmanOnly, BowlerOnly {
    func doBatting()
    func doBowling()
    func doFielding()
}

class AllRounderClass: AllRounderOnly {
    func doBatting() {
        // AllRounder batting implementation
    }

    func doBowling() {
        // AllRounder bowling implementation
    }

    func doFielding() {
        // AllRounder fielding implementation
    }
}

class BatsmanClass: BatsmanOnly {
    func doBatting() {
        // Batsman batting implementation
    }

    func doFielding() {
        // Batsman fielding implementation
    }
}

//class BowlerClass: Bow {
//    
//}


protocol Workable {
    func work()
}

protocol Eatable {
    func eat()
}

class Programmer: Workable, Eatable {
    func work() {
        print("Coding")
    }

    func eat() {
        print("Eating")
    }
}

class Robot: Workable {
    func work() {
        print("Building")
    }
}

protocol Switchable {
    func turnOn()
    func turnOff()
}

protocol TemperatureControllable {
    func setTemperature(_ temperature: Double)
}

class SmartLight: Switchable {
    func turnOn() {
        print("💡 Light turned on")
    }

    func turnOff() {
        print("💡 Light turned off")
    }
}

class SmartThermostat: Switchable, TemperatureControllable {
    func turnOn() {
        print("🌡️ Thermostat turned on")
    }

    func turnOff() {
        print("🌡️ Thermostat turned off")
    }

    func setTemperature(_ temperature: Double) {
        print("🌡️ Temperature set to \(temperature)°C")
    }
}

func controlDevice(_ device: Switchable) {
    device.turnOn()
}

let myLight = SmartLight()
controlDevice(myLight) // ✅ "💡 Light turned on"

let myThermostat = SmartThermostat()
controlDevice(myThermostat) // ✅ "🌡️ Thermostat turned on"
myThermostat.setTemperature(22.5) // ✅ "🌡️ Temperature set to 22.5°C"


