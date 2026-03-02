//
//  CounterCard.swift
//  StateManagement
//
//  Created by user on 02/03/26.
//

import SwiftUI

struct StepperControl: View {

    @Binding var value: Int

    var body: some View {
        HStack(spacing: 20) {
            Button("-") {
                value -= 1
            }

            Text("\(value)")
                .font(.title2)
                .frame(minWidth: 40)

            Button("+") {
                value += 1
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}
