//
//  Route.swift
//  DemoOffLineDBApp
//
//


import SwiftUI

final class Router: ObservableObject {

    @Published var path = NavigationPath()

    func push(_ route: AppRoute) {
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
}
