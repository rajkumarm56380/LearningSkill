//
//  View+Toast.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

public extension View {

    func toast(
        message: Binding<String?>,
        duration: Double = 2.0
    ) -> some View {

        ZStack {
            self

            if let msg = message.wrappedValue {
                VStack {
                    Spacer()
                    ToastView(message: msg)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .task {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            message.wrappedValue = nil
                        }
                    }
                }
            }
        }
        .animation(.easeInOut, value: message.wrappedValue)
    }
}
