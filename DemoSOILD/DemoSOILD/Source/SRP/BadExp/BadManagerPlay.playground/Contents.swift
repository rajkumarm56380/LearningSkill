import UIKit

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func handleAllActions() {
        let userData = getUsers()
        let userArray = parseDataToJson(data: userData)
        saveDataToDB(users: userArray)
    }

    func getUsers() -> Data {
        // Send API request and wait for response
        return Data()
    }

    func parseDataToJson(data: Data) -> [String] {
        // parse the data and convert to array
        return [""]
    }

    func saveDataToDB(users: [String]) {
        // save that array into coredata

    }
}

// Explanation:
// requestData() -> Request data from server
// parse() -> Parse the request data to required string array
// saveToDatabase() -> Save the parsed array to local disk

// ------------------------------------------------------------------
class UserManager {
    func saveUser(name: String) {
        // Save user to database
        print("User \(name) saved to database")
    }

    func sendWelcomeEmail(name: String) {
        // Send a welcome email
        print("Welcome email sent to \(name)")
    }

    func logUserActivity(name: String) {
        // Log user activity
        print("User activity logged for \(name)")
    }
}
