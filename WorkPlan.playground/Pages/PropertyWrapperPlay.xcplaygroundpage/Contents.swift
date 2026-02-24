//: [Previous](@previous)

import Foundation

print(String(repeating: "-", count: 50))
print("PROPERTY WRAPPER")

@propertyWrapper
struct MyWrapper {
    private var value: Int = 0
    
    init(wrappedValue: Int) {
        self.value = wrappedValue
    }
    
    var wrappedValue: Int {
        get { value }
        set { value = max(0, newValue)}
    }
}

struct Person {
    @MyWrapper var age: Int = -10
}
var person = Person()
print("result ==> ",person.age)

print(String(repeating: "-", count: 50))
@propertyWrapper
struct UpperCase {
    private var value: String = ""
    
    init(wrappedValue: String) {
        self.value = wrappedValue
    }
    var wrappedValue: String {
        get { value }
        set { value = newValue.uppercased() }
    }
}
    
struct TestCase {
    @UpperCase var name:String = ""
}

var obj = TestCase()
obj.name = "rajkumar"
print("Upper Case check ==> ", obj.name)
print(String(repeating: "-", count: 50))

@propertyWrapper
@MainActor
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    @MainActor var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

extension UserDefaults {
    
    @MainActor static let groupUserDefaults = UserDefaults(suiteName: "group.com.swiftlee.app")!

    @UserDefault(key: "has_seen_app_introduction", defaultValue: false, container: .groupUserDefaults)
    static var hasSeenAppIntroduction: Bool

    @UserDefault(key: "username", defaultValue: "Antoine van der Lee")
    static var username: String

    @UserDefault(key: "Skills", defaultValue: "iOS")
    static var yearOfBirth: String

    @UserDefault(key: "Values", defaultValue: 1000)
    static var values: Int

}

UserDefaults.hasSeenAppIntroduction = false
print("hasSeenAppIntroduction ==> ",UserDefaults.hasSeenAppIntroduction) // Prints: false

UserDefaults.hasSeenAppIntroduction = true
print("hasSeenAppIntroduction ==> ",UserDefaults.hasSeenAppIntroduction) // Prints: true

UserDefaults.username = "Rajkumar Mahalingam"
print("username ==> ",UserDefaults.username) // Prints: ajkumar Mahalingam

UserDefaults.values = 1000
print("values ==> ",UserDefaults.values) // Prints: 1000

print(String(repeating: "-", count: 50))

