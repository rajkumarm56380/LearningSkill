//
//  AppRouter.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

final class AppRouter: ObservableObject {

    @Published var path = NavigationPath()

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    func popToRoot() {
        path = NavigationPath()
    }

    func reset(to route: Route) {
        path = NavigationPath()   // clear stack
        path.append(route)        // set new root destination
    }

    func reset() {
        path = NavigationPath()
    }
}
