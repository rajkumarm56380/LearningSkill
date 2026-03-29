//
//  ValidationBuilder.swift
//  DemoOffLineDBApp
//
//

import Foundation

@resultBuilder
public struct ValidationBuilder {

    public static func buildBlock(_ components: ValidationRule...) -> [ValidationRule] {
        components
    }
}
