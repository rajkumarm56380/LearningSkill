//
//  ContentView.swift
//  DemoConcurrency
//
//  Created by user on 26/02/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
        var body: some View {
            VStack {
                Text("Counter: \(viewModel.counter)")
                    .font(.largeTitle)
                Button("Increment") {
                    viewModel.increment()
                }
            }
        }

}

#Preview {
    ContentView()
}
