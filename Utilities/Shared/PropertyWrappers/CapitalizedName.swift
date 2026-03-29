//
//  CapitalizedName.swift
//  DemoOffLineDBApp
//
//

import Foundation

@propertyWrapper
struct CapitalizedName {

    private var value: String = ""

    var wrappedValue: String {
        get { value }
        set {
            value = newValue
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .split(separator: " ")
                .map { $0.capitalized }
                .joined(separator: " ")
        }
    }

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
