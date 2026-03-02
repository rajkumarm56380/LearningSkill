import UIKit

protocol Animals {
    func eat()
    func fly()
    func swim()
}

class Flamingo: Animals {
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

class Dogs: Animals {
    func eat() {
        print("I can eat")
    }

    func fly() {
        print("I cannot fly")
        fatalError()
    }

    func swim() {
        print("I cannot swim")
        fatalError()
    }
}


protocol AllRounderWithoutISP {
    func doBatting()
    func doBowling()
    func doFielding()
}

class Batsman: AllRounderWithoutISP {
    func doBatting() {
        // Batsman batting implementation
    }

    func doFielding() {
        // Batsman fielding implementation
    }

    func doBowling() {
        // Batsman bowling implementation (not typical)
    }
}

class Bowler: AllRounderWithoutISP {
    func doBowling() {
        // Bowler bowling implementation
    }

    func doFielding() {
        // Bowler fielding implementation
    }

    func doBatting() {
        // Bowler batting implementation (not typical)
    }
}

class AllRounder: AllRounderWithoutISP {
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

class Substitute: AllRounderWithoutISP {
    func doFielding() {
        // Substitute fielding implementation
    }

    func doBatting() {
        // Substitute batting implementation (may be empty)
    }

    func doBowling() {
        // Substitute bowling implementation (may be empty)
    }
}

protocol Worker {
    func work()
    func eat()
}

class Programmer: Worker {
    func work() {
        print("Coding")
    }

    func eat() {
        print("Eating")
    }
}

class Robot: Worker {
    func work() {
        print("Building")
    }

    func eat() {
        // Robots don't eat!
        fatalError("Robots don't eat")
    }
}


protocol SmartDevice {
    func turnOn()
    func turnOff()
    func setTemperature(_ temperature: Double) // ❌ Not all devices support temperature control!
}

class SmartLight: SmartDevice {
    func turnOn() {
        print("💡 Light turned on")
    }

    func turnOff() {
        print("💡 Light turned off")
    }

    func setTemperature(_ temperature: Double) {
        fatalError("❌ Smart Light does not support temperature control!") // ❌ Breaks ISP
    }
}

class SmartThermostat: SmartDevice {
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

