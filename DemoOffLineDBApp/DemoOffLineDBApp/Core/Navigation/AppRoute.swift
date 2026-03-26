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
        path = NavigationPath()
        path.append(route)       
    }

    func reset() {
        path = NavigationPath()
    }
}
