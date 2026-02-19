import Foundation

print(String(repeating: "-", count: 50))
print("RESULT BUILDER")

@resultBuilder
struct StringBuilder {
    static func buildBlock(_ components: String...) -> Int {
        let numbers = components.compactMap({ Int($0)})
        var sum = 0
        numbers.forEach({
            sum += $0
        })
        return sum
    }
}

func build(@StringBuilder _ content: () -> Int) -> Int {
    content()
}

let longString = build {
 "Hello"
 "World"
 "Super"
 "Long"
}

print("longString ==> ",longString)
print(String(repeating: "-", count: 50))

@resultBuilder
struct StringBuilderBlock {

    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: "\n")
    }
}

func makeText(@StringBuilderBlock content: () -> String) -> String {
    content()
}

let result = makeText {
    "Hello"
    "World"
}

print("result ==> ",result)
print(String(repeating: "-", count: 50))

//MARK: -
/// Adding Conditional Support

@resultBuilder
struct StringBuilders {

    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: "\n")
    }

    static func buildEither(first component: String) -> String {
        component
    }

    static func buildEither(second component: String) -> String {
        component
    }
}

makeText {
    "Start"
    if Bool.random() {
        "True"
    } else {
        "False"
    }
}
