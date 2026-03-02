import UIKit



// Abstraction: Animal
protocol Animal {
    func makeSound()
}

// Low-level class: Dog
class Dog: Animal {
    func makeSound() {
        print("Woof!")
    }
}

// Low-level class: Cat
class Cat: Animal {
    func makeSound() {
        print("Meow!")
    }
}

// High-level class: AnimalSoundMaker
class AnimalSoundMaker {
    let animal: Animal

    init(animal: Animal) {
        self.animal = animal
    }

    func performSound() {
        animal.makeSound()
    }
}

protocol AndroidDevelopment {
    func doAndroid()
}

protocol IOSDevelopment {
    func doIOS()
}

protocol ReactDevelopment {
    func doReactNative()
}

class Development: AndroidDevelopment, IOSDevelopment, ReactDevelopment {
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

class AndroidDevelopmentOnly: AndroidDevelopment {
    func doAndroid() {
        // Android development implementation
    }
}


protocol DataService {
    func fetchData() -> String
}

class DatabaseService: DataService {
    func fetchData() -> String {
        return "Data from database"
    }
}

class DataManager {
    private let dataService: DataService

    init(dataService: DataService) {
        self.dataService = dataService
    }

    func getData() -> String {
        return dataService.fetchData()
    }
}

// Usage
let databaseService = DatabaseService()
let dataManager = DataManager(dataService: databaseService)
print(dataManager.getData())


protocol NotificationService {
    func sendNotification(to recipient: String, message: String)
}

class EmailService: NotificationService {
    func sendNotification(to recipient: String, message: String) {
        print("📧 Email sent to \(recipient): \(message)")
    }
}

class SMSService: NotificationService {
    func sendNotification(to recipient: String, message: String) {
        print("📩 SMS sent to \(recipient): \(message)")
    }
}

class UserNotificationManager {
    private let notificationService: NotificationService

    init(notificationService: NotificationService) {
        self.notificationService = notificationService
    }

    func sendNotification(to recipient: String, message: String) {
        notificationService.sendNotification(to: recipient, message: message)
    }
}

class PushNotificationService: NotificationService {
    func sendNotification(to recipient: String, message: String) {
        print("📲 Push Notification sent to \(recipient): \(message)")
    }
}

let emailNotification = UserNotificationManager(notificationService: EmailService())
emailNotification.sendNotification(to: "user@example.com", message: "Hello via Email!")
// ✅ "📧 Email sent to user@example.com: Hello via Email!"

let smsNotification = UserNotificationManager(notificationService: SMSService())
smsNotification.sendNotification(to: "+123456789", message: "Hello via SMS!")
// ✅ "📩 SMS sent to +123456789: Hello via SMS!"

let pushNotification = UserNotificationManager(notificationService: PushNotificationService())
pushNotification.sendNotification(to: "User123", message: "Hello via Push Notification!")
// ✅ "📲 Push Notification sent to User123: Hello via Push Notification!"


