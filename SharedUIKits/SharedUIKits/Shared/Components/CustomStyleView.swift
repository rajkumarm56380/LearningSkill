//
//  CustomStyleView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

public struct CustomStyleView: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .padding()
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .textCase(.lowercase)
            .cornerRadius(10)
    }
}

