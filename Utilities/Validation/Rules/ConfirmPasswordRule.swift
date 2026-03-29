//
//  ConfirmPasswordRule.swift
//  DemoOffLineDBApp
//
//

import Foundation

struct ConfirmPasswordRule: ValidationRule {

    let password: String
    let confirm: String

    func validate() -> String? {
        password == confirm ? nil : "Passwords do not match"
    }
}
