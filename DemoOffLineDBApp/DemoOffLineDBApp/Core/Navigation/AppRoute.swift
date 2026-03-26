//
//  AppRouter.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

final class AppRouter: ObservableObject {

    @Published var path: [Route] = []

    func push(_ route: Route) {
        print("PUSH:", route)
        path.append(route)
    }

    func popLast() {
        _ = path.popLast()
    }

    func reset(to route: Route) {
        print("RESET TO:", route) // DEBUG
        path = [route]
    }

    func reset() {
        path.removeAll()
    }
}
