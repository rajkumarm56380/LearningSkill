//
//  APIEndPoint.swift
//  VenuesApp
//
//

import Foundation

enum APIEndPoint: String {
    case endpoint = "https://serpapi.com/search.json?"
    case apiKeyValue = "4559707b6dcced7bb53223464c9d50205c0af7bbe1b1b23110033b4223f3ca27"
    case apiKey = "api_key"
}

enum APIParam: String {
    case param = "engine=google_local&q=Coffee&location=Bangalore+India&device=mobile"
}

enum APIError: Error {
    case invalidRequestError(String)
    case transportError(Error)
    case internalError(_ statusCode: Int)
    case serverError(_ statusCode: Int)
}
