//
//  CounterViewModel.swift
//  StateManagement
//
//  Created by user on 02/03/26.
//

import Combine
import SwiftUI

final class CounterViewModel: ObservableObject {

    @Published var count: Int = 0

    var isEven: Bool {
        count % 2 == 0
    }

    func increment() {
        count += 1
    }

    func decrement() {
        count -= 1
    }
}
