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
    case recipeDetail(Recipe)
    case settings
}
