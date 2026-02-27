import Foundation

print(String(repeating: "-", count: 50))
print("RESULT BUILDER")
print("------------- BUILDBLOCK METHOD ---------------")
// Purpose
// Combines multiple expressions inside the builder block.

@resultBuilder

struct SimpleStringBuilder {
    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: "\n")
    }
}

let joined = SimpleStringBuilder.buildBlock(
    "Testing",
    "iOS",
    "result builder"
)
print("Simple Joined String ==>", joined)
print(String(repeating: "-", count: 50))

@SimpleStringBuilder func makeSentence3() -> String {
    "Why settle for a Duke"
    "when you can have"
    "a Prince?"
}

print("makeSentence3 ==>", makeSentence3())
print(String(repeating: "-", count: 50))
print("------ConditionalStringBuilder----------")

@resultBuilder
struct conditionalStringBuilder {
    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: "\n")
    }

    static func buildEither(first component: String) -> String {
        return component
    }

    static func buildEither(second component: String) -> String {
        component
    }
}

@conditionalStringBuilder func makeConditionString() -> String {
    "Why settle for a Duke"
    "when you can have"
    if Bool.random() {
        "a Prince?"
    } else {
        "a king?"
    }
}

print("makeConditionString ==>", makeConditionString())
print(String(repeating: "-", count: 50))

@resultBuilder
struct StringIntBuilders {
    // // Required buildBlock to combine components
    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: "\n")
    }

    // Optional buildExpression to handle raw String literals
    static func buildExpression(_ expression: String) -> String {
        expression
    }

    // Optional buildExpression overload to handle Int literals and convert them to String
    static func buildExpression(_ expression: Int) -> String {
        String(describing: expression)
    }
}

func buildString(@StringIntBuilders block: () -> String) -> String {
    block()
}

let buildStringResult = buildString {
    "Hello"        // Calls buildExpression("Hello")
    123            // Calls buildExpression(123)
    "World"        // Calls buildExpression("World")
}

print(buildStringResult)
// Output: Hello 123 World

print(String(repeating: "-", count: 50))
print("String Array")
@resultBuilder
struct ComplexStringBuilder {
    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: "\n")
    }

    static func buildEither(first component: String) -> String {
        return component
    }

    static func buildEither(second component: String) -> String {
        return component
    }

    static func buildArray(_ components: [String]) -> String {
        components.joined(separator: "\n")
    }
}

@ComplexStringBuilder func countDown() -> String {
    for i in (0...10).reversed() {
        "\(i)..."
    }
    "Lift off!"
}

print("ComplexStringBuilder ===>", countDown())

@resultBuilder
struct StringArray {
   static func buildBlock(_ components: String...) -> [String] {
        components
    }
}

func makeStringArray(@StringArray content:() -> [String]) -> [String] {
    content()
}

let resultStringArray = makeStringArray {
    "Rajkumar"
    "Mahalingam"
    "iOS"
}

print("RESULT STRING ARRAY", resultStringArray)
print(String(repeating: "-", count: 50))

@resultBuilder
struct IntArray {
    static func buildBlock(_ components: Int...) -> [Int] {
        components
    }
}

func makeIntArray(@IntArray content:() -> [Int]) -> [Int] {
    content()
}

let resultIntArray = makeIntArray {
    40
    90
    70
    10
}

print("RESULT INT ARRAY", resultIntArray)
print(String(repeating: "-", count: 50))

@resultBuilder
struct UpperCase {
    static func buildBlock(_ components: String) -> String {
        components.uppercased()
    }
}

func makeUpperCase(@UpperCase content:() -> String) -> String {
    content()
}

let caseString = makeUpperCase{
    "rajkumar mahalingam"
}

print("Case String",caseString)

enum CaseType {
    case upper(String)
    case lower(String)
    case trimSpace(String)
}

@resultBuilder
struct ValidStringBuilder {

    static func buildBlock(_ components: String) -> String {
        components
    }

    static func buildEither(first component: String) -> String {
        component
    }

    static func buildEither(second component: String) -> String {
        component
    }
}

func makeValidStrings(@ValidStringBuilder content:() -> String) -> String {
    content()
}

let results: CaseType = .trimSpace(" rajkumar mahalingam ")

let getString = makeValidStrings {
    switch results {
    case .upper(let stringContent):
        stringContent.uppercased()
    case .lower(let stringContent):
        stringContent.lowercased()
    case .trimSpace(let stringContent):
        stringContent.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

print("Valid String ==>", getString)

@resultBuilder
struct UpperBuilder {
    static func buildBlock(_ components: String...) -> [String] {
        components
    }
    static func buildExpression(_ expression: String) -> String {
        expression.uppercased()
    }
}

func makeBuilder(@UpperBuilder content: () -> [String]) -> [String] {
    content()
}

let caseBuilder = makeBuilder {
    "rajkumar"
    "mahalingam"
    "iOS"
}

@resultBuilder
struct OptionalBuilder {
  static func buildBlock(_ component: String...) -> String {
      component.joined(separator: ",")
  }
  static func buildOptional(_ component: String?) -> String
    {
        component ?? "nil"
    }
}

let showFlag = true
@OptionalBuilder
func makeOptional(flag: Bool) -> String {
    "Always"
    if flag {
        "optional"
    }
    "Test"
}

print(makeOptional(flag: false))
print(makeOptional(flag: true))

@resultBuilder
struct ArrayBuild {
    static func buildBlock(_ components: [[String]]) -> [String] {
        components.flatMap{$0}
    }
}

/*@ArrayBuild
func makeArrayBuilder() -> [String] {
    "Always"
    "optional"
    "Test"
}*/

@resultBuilder
struct HTMLBuilder {

    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: "\n")
    }

    static func buildExpression(_ expression: String) -> String {
        expression
    }

    static func buildOptional(_ component: String?) -> String {
        component ?? ""
    }

    static func buildEither(first component: String) -> String {
        component
    }

    static func buildEither(second component: String) -> String {
        component
    }

    static func buildArray(_ components: [String]) -> String {
        components.joined(separator: "\n")
    }
}

func html(@HTMLBuilder content: () -> String) -> String {
    content()
}

let page = html {
    "<h1>Title</h1>"
    
    if true {
        "<p>Condition met</p>"
    }
    
    for i in 1...3 {
        "<li>Item \(i)</li>"
    }
}

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

func makeBlock(@StringBuilders content:()-> String)  -> String {
    content()
}

let resultBlock = makeBlock {
    "Rajkumar"
    if Bool.random() {
        "Mahalingam"
    } else {
        "iOS"
    }
}

print(resultBlock)

