//
//  AuthTextFieldView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

public struct AuthTextFieldView: View {
    public let title: String
    @Binding public var text: String
    public var isSecure: Bool

    public init(
        title: String,
        text: Binding<String>,
        isSecure: Bool = false
    ) {
        self.title = title
        self._text = text
        self.isSecure = isSecure
    }

    public var body: some View {
        Group {
            if isSecure {
                SecureField(title, text: $text)
                    .textContentType(.init(rawValue: ""))
                    .textContentType(.none)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
            } else {
                TextField(title, text: $text)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .textContentType(.none)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}
