//
//  ValidationBuilder.swift
//  DemoOffLineDBApp
//
//

import Foundation

@resultBuilder
struct ValidationBuilder {

    static func buildBlock(_ components: ValidationRule...) -> [ValidationRule] {
        components
    }
}
