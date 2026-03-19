//
//  AthuError.swift
//  DemoOffLineDBApp
//
//

import Foundation

enum AuthError: LocalizedError {
    case userAlreadyExists
    case invalidCredentials
    case userNotFound

    var errorDescription: String? {
        switch self {
        case .userAlreadyExists:
            return "User already exists"
        case .invalidCredentials:
            return "Invalid email or password"
        case .userNotFound:
            return "User Not Found!"
        }
    }
}
