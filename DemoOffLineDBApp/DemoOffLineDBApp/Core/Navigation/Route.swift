//
//  Route.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

enum Route: Hashable {
    case login
    case signup
    case foodLists
    case settings
    case recipeDetail(Recipe)
}
