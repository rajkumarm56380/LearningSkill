import Foundation

print(String(repeating: "-", count: 50))
print("RESULT BUILDER")
print("BUILDBLOCK METHOD")
// Purpose
// Combines multiple expressions inside the builder block.

print("String Array")

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
    static func buildExpression(_ expression: String) -> String {
        expression.uppercased()
    }
    static func buildBlock(_ components: String...) -> [String] {
        components
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

