//
//  ToastView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

public struct ToastView: View {

    let message: String

    public init(message: String) {
        self.message = message
    }

    public var body: some View {
        Text(message)
            .font(.footnote)
            .foregroundColor(.white)
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.bottom, 40)
    }
}
