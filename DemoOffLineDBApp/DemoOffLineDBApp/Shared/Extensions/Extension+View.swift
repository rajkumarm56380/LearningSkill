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
            .toolbarBackground(.purple, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationBarBackButtonHidden(true)

    }

    func applyButtonStyle() -> some View {
        self.foregroundColor(.white)
            .fontWeight(.semibold)
            .font(.title)
            .frame(maxWidth: .infinity,maxHeight: 45)
            .padding()
            .foregroundColor(Color.white)
            .background(AppConstants.appColour)
            .cornerRadius(40)
    }
    
    func customStyle() -> some View {
           modifier(CustomStyleView())
    }

    func loading(_ isLoading: Bool) -> some View {
        self.overlay {
            if isLoading {
                LoadingView()
            }
        }
    }
}

