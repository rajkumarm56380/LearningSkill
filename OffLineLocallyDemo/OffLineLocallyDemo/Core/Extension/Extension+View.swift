//
//  Extension+View.swift
//  OffLineLocallyDemo
//
//

import Foundation
import SwiftUI

extension View {
    func appNavigationStyle() -> some View {
        self
            .toolbarBackground(Color.blue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarBackButtonHidden(true)

    }

    func applyBackgroundColor() -> some View {
        self.background(Color.purple.opacity(0.5))
    }
    func customStyle() -> some View {
           modifier(CustomStyle())
       }
}
