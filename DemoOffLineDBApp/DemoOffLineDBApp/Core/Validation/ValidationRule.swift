//
//  ValidationRule.swift
//  DemoOffLineDBApp
//
//  Created by Apple on 28/03/26.
//

import Foundation

protocol ValidationRule {
    func validate() -> String?
}

struct ValidationResult {
    let error: String?
}
