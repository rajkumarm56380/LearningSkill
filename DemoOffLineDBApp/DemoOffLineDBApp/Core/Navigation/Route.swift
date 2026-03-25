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
    case productDetail(Product)
    case settings
}
