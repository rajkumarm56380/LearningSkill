//
//  CounterScreenView.swift
//  StateManagement
//
//  Created by user on 02/03/26.
//

import SwiftUI

struct CounterScreenView: View {

    @StateObject private var viewModel = CounterViewModel()
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        VStack(spacing: 30) {
            CounterCardView(viewModel: viewModel)
            Button("Switch Theme") {
                theme.toggleTheme()
            }
        }
        .padding()
    }
}
