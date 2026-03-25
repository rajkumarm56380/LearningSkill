//
//  ErrorTextView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct ErrorTextView: View {
    let message: String?

    var body: some View {
        if let message = message {
            Text(message)
                .foregroundColor(.red)
                .font(.footnote)
                .padding(.top, 4)
        }
    }
}
