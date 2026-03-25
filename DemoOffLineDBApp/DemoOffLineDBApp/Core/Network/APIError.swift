//
//  APIError.swift
//  DemoOffLineDBApp
//
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingError
    case networkError(String)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid response"
        case .httpError(let code): return "HTTP Error: \(code)"
        case .decodingError: return "Failed to decode data"
        case .networkError(let msg): return msg
        case .unknown: return "Unknown error"
        }
    }
}
