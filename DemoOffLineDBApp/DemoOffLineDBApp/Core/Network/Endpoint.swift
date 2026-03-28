//
//  Endpoint.swift
//  DemoOffLineDBApp
//

import Foundation

enum APIConstants {
    static let baseURL = "https://dummyjson.com"
}

enum Endpoint {

    case recipes

    var path: String {
        switch self {
        case .recipes:
            return "/recipes"
        }
    }

    var url: URL {
        URL(string: APIConstants.baseURL + path)!
    }
}
