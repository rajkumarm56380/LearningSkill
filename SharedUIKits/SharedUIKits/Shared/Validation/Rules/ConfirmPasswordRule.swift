//
//  ConfirmPasswordRule.swift
//  DemoOffLineDBApp
//
//

import Foundation

public struct ConfirmPasswordRule: ValidationRule {

    public let password: String
    public let confirm: String

    public init(password: String, confirm: String) {
        self.password = password
        self.confirm = confirm
    }

    public func validate() -> String? {
        password == confirm ? nil : "Passwords do not match"
    }
}
