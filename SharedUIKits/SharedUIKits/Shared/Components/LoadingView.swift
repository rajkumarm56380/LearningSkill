//
//  LoadingView.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

public struct LoadingView: View {
    public var message: String = "Loading..."

    public var body: some View {
        ZStack {
            // Background blur
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                ProgressView()
                    .scaleEffect(1.5)

                Text(message)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 10)
        }.ignoresSafeArea()
    }
}
