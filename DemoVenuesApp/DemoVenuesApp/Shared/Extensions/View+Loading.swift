//
//  View+Loading.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

extension View {
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
