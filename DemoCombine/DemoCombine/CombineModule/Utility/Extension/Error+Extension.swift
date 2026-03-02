//
//  Error+Extension.swift
//  DemoCombine
//
//  Created by Apple on 02/03/26.
//

import Foundation

enum AuthError: LocalizedError {
    case userNotFound
    case userAlreadyExists

    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "User not found"
        case .userAlreadyExists:
            return "User already exists"
        }
    }
}

enum ValidationError: LocalizedError {
    case invalidInput

    var errorDescription: String? {
        switch self {
        case .invalidInput:
            return "Please fill all fields"
        }
    }
}
