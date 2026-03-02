import UIKit

// Low-level class: Dog
class Dog {
    func bark() {
        print("Woof!")
    }
}

// Low-level class: Cat
class Cat {
    func meow() {
        print("Meow!")
    }
}

// High-level class: AnimalSoundMaker
class AnimalSoundMaker {
    let dog: Dog
    let cat: Cat

    init(dog: Dog, cat: Cat) {
        self.dog = dog
        self.cat = cat
    }

    func makeDogSound() {
        dog.bark()
    }

    func makeCatSound() {
        cat.meow()
    }
}

class Developer {
    func doIOS() {
        // iOS development implementation
    }

    func doAndroid() {
        // Android development implementation
    }

    func doReactNative() {
        // React Native development implementation
    }
}

let developer = Developer()
developer.doIOS()
developer.doAndroid()
developer.doReactNative()


class AndroidDeveloper: Developer {
    override func doIOS() {
        // AndroidDeveloper does not do iOS, but method must be overridden
    }

    override func doAndroid() {
        // Android development implementation
    }

    override func doReactNative() {
        // AndroidDeveloper does React Native development
    }
}


class DatabaseService {
    func fetchData() -> String {
        return "Data from database"
    }
}

class DataManager {
    private let databaseService = DatabaseService()

    func getData() -> String {
        return databaseService.fetchData()
    }
}

class EmailService {
    func sendEmail(to recipient: String, message: String) {
        print("📧 Email sent to \(recipient): \(message)")
    }
}

class SMSService {
    func sendSMS(to recipient: String, message: String) {
        print("📩 SMS sent to \(recipient): \(message)")
    }
}

class UserNotificationManager {
    private let emailService = EmailService() // ❌ Directly depending on concrete class
    private let smsService = SMSService() // ❌ Directly depending on concrete class

    func sendNotification(to recipient: String, message: String, viaEmail: Bool) {
        if viaEmail {
            emailService.sendEmail(to: recipient, message: message)
        } else {
            smsService.sendSMS(to: recipient, message: message)
        }
    }
}

