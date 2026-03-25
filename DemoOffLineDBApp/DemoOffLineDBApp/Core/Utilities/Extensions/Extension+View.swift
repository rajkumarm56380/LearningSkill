//
//  Extension+View.swift
//  DemoOffLineDBApp
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

    func applyButtonStyle() -> some View {
        self.foregroundColor(.white)
            .font(.system(size: 24, weight: .bold, design: .default))
            .frame(maxWidth: .infinity, maxHeight: 60)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(10)
    }
    
    func customStyle() -> some View {
           modifier(CustomStyleView())
    }
}

