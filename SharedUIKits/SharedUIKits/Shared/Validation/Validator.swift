//
//  Validator.swift
//  DemoOffLineDBApp
//
//

import Foundation

public struct Validator {

   public static func validate(@ValidationBuilder _ rules: () -> [ValidationRule]) -> String? {
        for rule in rules() {
            if let error = rule.validate() {
                return error // return first error
            }
        }
        return nil
    }
}
