//
//  CapitalizedName.swift
//  DemoOffLineDBApp
//
//

import Foundation

@propertyWrapper
public struct CapitalizedName {

    private var value: String = ""

    public var wrappedValue: String {
        get { value }
        set {
            value = newValue
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .split(separator: " ")
                .map { $0.capitalized }
                .joined(separator: " ")
        }
    }

    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
