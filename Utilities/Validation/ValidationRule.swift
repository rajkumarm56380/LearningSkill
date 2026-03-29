//
//  ValidationRule.swift
//  DemoOffLineDBApp
//
//

import Foundation

protocol ValidationRule {
    func validate() -> String?
}

struct ValidationResult {
    let error: String?
}
