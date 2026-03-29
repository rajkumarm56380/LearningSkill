//
//  ValidationRule.swift
//  DemoOffLineDBApp
//
//

import Foundation

public protocol ValidationRule {
    func validate() -> String?
}

public struct ValidationResult {
    public let error: String?
}
