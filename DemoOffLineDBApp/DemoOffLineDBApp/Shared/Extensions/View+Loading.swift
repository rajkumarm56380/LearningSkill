//
//  View+Loading.swift
//  DemoOffLineDBApp
//
//  Created by Apple on 25/03/26.
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
