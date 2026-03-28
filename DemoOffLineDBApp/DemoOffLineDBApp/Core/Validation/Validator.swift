//
//  Validator.swift
//  DemoOffLineDBApp
//
//

import Foundation

struct Validator {

    static func validate(@ValidationBuilder _ rules: () -> [ValidationRule]) -> String? {
        for rule in rules() {
            if let error = rule.validate() {
                return error // return first error
            }
        }
        return nil
    }
}
