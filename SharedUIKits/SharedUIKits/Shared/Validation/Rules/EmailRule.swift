//
//  EmailRule.swift
//  DemoOffLineDBApp
//
//

import Foundation

public struct EmailRule: ValidationRule {

    public let email: String

    public init(_ email: String) {
        self.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public func validate() -> String? {

        if email.isEmpty {
            return "Email is required"
        }

        let pattern =
        #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        let isValid = NSPredicate(format: "SELF MATCHES %@", pattern)
            .evaluate(with: email)

        return isValid ? nil : "Enter a valid email address"
    }
}
