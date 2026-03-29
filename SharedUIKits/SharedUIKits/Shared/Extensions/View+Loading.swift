//
//  View+Loading.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

public extension View {
    func loadingOverlay(_ isLoading: Bool) -> some View {
        ZStack {
            self.overlay {
                if isLoading {
                    LoadingView()
                }
            }
        }
    }
}
