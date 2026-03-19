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
    func customStyle() -> some View {
           modifier(CustomStyle())
       }
}
