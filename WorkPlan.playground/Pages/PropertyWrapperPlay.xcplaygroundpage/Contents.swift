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
struct Clamped<Value: Comparable> {
    private var value: Value
    private let range: ClosedRange<Value>
    
    // The required initializer to accept the initial value and configuration
    init(wrappedValue value: Value, _ range: ClosedRange<Value>) {
        self.range = range
        self.value = min(max(value, range.lowerBound), range.upperBound)
    }
    
    // The required property that the compiler uses for get and set operations
    var wrappedValue: Value {
        get { value }
        set {
            // Apply the clamping logic whenever the value is set
            value = min(max(newValue, range.lowerBound), range.upperBound)
        }
    }
}
struct GameSettings {
    // Usage with Int
    @Clamped(0...100) var volume: Int = 50
    
    // Usage with Double (requires a Double range)
    @Clamped(0.0...1.0) var brightness: Double = 0.8
}

var settings = GameSettings()

print(settings.volume) // Prints "50"
settings.volume = 120
print(settings.volume) // Prints "100" (clamped to max value)

print(settings.brightness) // Prints "0.8"
settings.brightness = -0.5
print(settings.brightness) // Prints "0.0" (clamped to min value)

@propertyWrapper
@MainActor
struct UserDefaultNew<Value> {
    private let key: String
    private let defaultValue: Value
    private let userDefaults: UserDefaults

    init(_ key: String, defaultValue: Value, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }

    var wrappedValue: Value {
        get {
            guard let value = userDefaults.object(forKey: key) else {
                return defaultValue
            }

            return value as? Value ?? defaultValue
        }
        set {
            if let value = newValue as? OptionalProtocol, value.isNil() {
                userDefaults.removeObject(forKey: key)
            } else {
                userDefaults.set(newValue, forKey: key)
            }
        }
    }
}

fileprivate protocol OptionalProtocol {
    func isNil() -> Bool
}

extension Optional : OptionalProtocol {
    func isNil() -> Bool {
        return self == nil
    }
}

struct TestUserDefaults {
    @UserDefaultNew("username_key", defaultValue:"Testing")
    static var username: String
}

let objCaseUS: () = TestUserDefaults.username = "Rajkumar"
print(objCaseUS)

@propertyWrapper
@MainActor
struct UserDefaultSam<Value> {
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

extension UserDefaultSam {
    
   // @MainActor static let groupUserDefaults = UserDefaultSam(suiteName: "group.com.swiftlee.app")!
/*
    @UserDefaultSam(key: "has_seen_app_introduction", defaultValue: false, container: .groupUserDefaults)
    static var hasSeenAppIntroduction: Bool

    @UserDefaultSam(key: "username", defaultValue: "Antoine van der Lee")
    static var username: String

    @UserDefaultSam(key: "Skills", defaultValue: "iOS")
    static var yearOfBirth: String

    @UserDefaultSam(key: "Values", defaultValue: 1000)
    static var values: Int
*/
}

/*
UserDefaultSam.hasSeenAppIntroduction = false
print("hasSeenAppIntroduction ==> ",UserDefaults.hasSeenAppIntroduction) // Prints: false

UserDefaultSam.hasSeenAppIntroduction = true
print("hasSeenAppIntroduction ==> ",UserDefaults.hasSeenAppIntroduction) // Prints: true

UserDefaults.username = "Rajkumar Mahalingam"
print("username ==> ",UserDefaults.username) // Prints: ajkumar Mahalingam

UserDefaults.values = 1000
print("values ==> ",UserDefaults.values) // Prints: 1000
*/
print(String(repeating: "-", count: 50))

@propertyWrapper
struct TestString {
    private var value: String = ""
    var wrappedValue: String {
        get { value }
        set { value = newValue.uppercased()
        }
    }
}

struct TestingCase {
    @TestString private var name
}

var objCase = TestCase()
objCase.name = "testing"
print(objCase.name)



@propertyWrapper
@MainActor
struct CustomDefaults<Value> {
    let key: String
    let defaultValue: Value
    @MainActor var container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
            container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

extension CustomDefaults {
    
    @CustomDefaults(key: "Tesing", defaultValue: "Testing")
    static var name: String
    
}
