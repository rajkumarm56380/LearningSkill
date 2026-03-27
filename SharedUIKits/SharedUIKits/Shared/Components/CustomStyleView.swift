//
//  CustomStyleView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct CustomStyleView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .textCase(.lowercase)
            .cornerRadius(10)
    }
}

