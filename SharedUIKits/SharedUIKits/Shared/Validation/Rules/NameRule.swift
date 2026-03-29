//
//  NameRule.swift
//  DemoOffLineDBApp
//
//

import Foundation

public struct NameRule: ValidationRule {

    let name: String
    let minLength: Int
    let maxLength: Int

    public init(_ name: String,
         minLength: Int = 3,
         maxLength: Int = 30) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.minLength = minLength
        self.maxLength = maxLength
    }

    public func validate() -> String? {

        if name.isEmpty {
            return "Name is required"
        }

        if name.count < minLength {
            return "Name must be at least \(minLength) characters"
        }

        if name.count > maxLength {
            return "Name must be less than \(maxLength) characters"
        }

        // Only alphabets + space
        /*let pattern = #"^[A-Za-z ]+$"#
        let isValid = NSPredicate(format: "SELF MATCHES %@", pattern)
            .evaluate(with: name)

        if !isValid {
            return "Name should contain only letters"
        }*/

        return nil
    }
}
