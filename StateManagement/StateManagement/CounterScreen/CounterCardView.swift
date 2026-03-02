//
//  CounterCardView.swift
//  StateManagement
//
//  Created by user on 02/03/26.
//

import Combine
import SwiftUI

struct CounterCardView: View {

    @ObservedObject var viewModel: CounterViewModel
    @EnvironmentObject var theme: ThemeManager
    //@State private var isExpanded: Bool = false

    var body: some View {
        VStack(spacing: 16) {

            HStack {
                Text("Counter")
                .font(.headline)
                Spacer()
            }
            StepperControl(value: $viewModel.count)
            Text(viewModel.isEven ? "Even" : "Odd")
            .foregroundColor(viewModel.isEven ? .green : .red)
        }
        .padding()
        .background(theme.primaryColor.opacity(0.15))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
