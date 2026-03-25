//
//  Route.swift
//  DemoOffLineDBApp
//
//

import SwiftUI

enum Route: Hashable {
    case login
    case signup
    case productList
    case recipeDetail(Recipe)
    case settings
}
