import UIKit

import Foundation

// Class following Single Responsibility Principle (SRP)
class APIHandlerWithSRP {

    let apiHandler: NetworkHandler
    let parseHandler: ResponseHandler
    let databaseHandler: DatabaseHandler

    init(apiHandler: NetworkHandler, parseHandler: ResponseHandler, dbHandler: DatabaseHandler) {
        self.apiHandler = apiHandler
        self.parseHandler = parseHandler
        self.databaseHandler = dbHandler
    }

    func handle() {
        let data = apiHandler.requestData()
        let array = parseHandler.parse(data: data)
        databaseHandler.saveToDatabase(array: array)
    }
}

class NetworkHandler {
    func requestData() -> Data {
        // Network request and wait for the response
        return Data()
    }
}

class ResponseHandler {
    func parse(data: Data) -> [String] {
        // Parse the network response into array
        return [String]()
    }
}

class DatabaseHandler {
    func saveToDatabase(array: [String]) {
        // Save parsed response into database
    }
}

class UserRepository {
    func saveUser(name: String) {
        print("User \(name) saved to database")
    }
}

class EmailService {
    func sendWelcomeEmail(name: String) {
        print("Welcome email sent to \(name)")
    }
}

class ActivityLogger {
    func logUserActivity(name: String) {
        print("User activity logged for \(name)")
    }
}

// Usage
let userRepository = UserRepository()
let emailService = EmailService()
let activityLogger = ActivityLogger()

let userName = "John Doe"
userRepository.saveUser(name: userName)
emailService.sendWelcomeEmail(name: userName)
activityLogger.logUserActivity(name: userName)
