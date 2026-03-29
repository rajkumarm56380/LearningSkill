//
//  ToastView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

struct ToastView: View {

    let message: String

    var body: some View {
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
