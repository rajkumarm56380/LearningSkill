//
//  ContentView.swift
//  DemoConcurrency
//
//  Created by user on 26/02/26.
//

import SwiftUI

struct ContentView: View {
    @State private var message = "Loading..."
    @State private var results: [String] = ["Loading..."]

    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            VStack {
                ForEach(results, id: \.self) { Text($0) }
            }
            .task {
                await loadAllData()
            }

            Text(message)
                .task {
                    let resut = await viewModel.fetchMessage()
                    message = resut
                }

            HStack {
                Button("Increment") {
                    viewModel.increment()
                }

                Text("Counter: \(viewModel.counter)")
                    .font(.largeTitle)

                Button("decrement") {
                    viewModel.decrement()
                }
           }
        }
    }

    func loadAllData() async {
        results = []
        await withTaskGroup(of: String.self) { group in
            group.addTask { await viewModel.fetch("Profile", delay:800_000_000) }
            group.addTask { await viewModel.fetch("Setting", delay:1_200_000_000) }

            for await value in group {
                results.append(value) //// UI updates as results come in
            }
        }
    }
}

#Preview {
    ContentView()
}
