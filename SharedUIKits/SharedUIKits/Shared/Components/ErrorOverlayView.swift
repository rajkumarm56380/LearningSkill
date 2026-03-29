//
//  ErrorOverlayView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

public struct ErrorOverlayView: View {

    let message: String
    var retryAction: (() -> Void)?

    public var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            VStack(spacing: 16) {

                Text("Something went wrong")
                    .font(.headline)

                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                if let retryAction {
                    Button("Retry") {
                        retryAction()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 10)
        }
    }
}
