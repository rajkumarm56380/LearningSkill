//: [Previous](@previous)

import Foundation

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
print(person.age)


@propertyWrapper
struct UpperCase {
    private var value: String = ""
    
    init(wrappedValue: String) {
        self.value = wrappedValue
    }
    var wrappedValue: String {
        get { value }
        set { value = newValue }
    }
}
    
struct TestCase {
    @UpperCase var name:String = ""
}

var obj = TestCase()
obj.name = "rajkumr"
print("Case check", obj.name)

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    
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
    
    nonisolated(unsafe) static let groupUserDefaults = UserDefaults(suiteName: "group.com.swiftlee.app")!
    
    @UserDefault(key: "has_seen_app_introduction", defaultValue: false, container: .groupUserDefaults)
    static var hasSeenAppIntroduction: Bool
    
    @UserDefault(key: "username", defaultValue: "Antoine van der Lee")
    static var username: String

    @UserDefault(key: "year_of_birth", defaultValue: 1990)
    static var yearOfBirth: Int
    
}



UserDefaults.hasSeenAppIntroduction = false
print(UserDefaults.hasSeenAppIntroduction) // Prints: false
UserDefaults.hasSeenAppIntroduction = true
print(UserDefaults.hasSeenAppIntroduction) // Prints: true
