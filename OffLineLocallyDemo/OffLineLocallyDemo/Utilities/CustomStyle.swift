//
//  CustomStyle.swift
//  OffLineLocallyDemo
//
//

import SwiftUI

struct CustomStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .textCase(.lowercase)
            .cornerRadius(10)
    }
}
