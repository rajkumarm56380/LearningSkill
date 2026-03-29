//
//  ErrorTextView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

public struct ErrorTextView: View {
    let message: String?

    init(message: String?) {
        self.message = message
    }
    public var body: some View {
        if let message = message {
            Text(message)
                .foregroundColor(.red)
                .font(.footnote)
                .padding(.top, 4)
        }
    }
}
