//
//  AthuError.swift
//  DemoOffLineDBApp
//
//

import Foundation

enum AuthError: LocalizedError, Equatable {

    case weakPassword
    case emptyFields
    case userNotFound
    case wrongPassword
    case userAlreadyExists
    case emailAlreadyInUse
    case invalidEmail
    case unknown(String)
    case credentialExpired

    var errorDescription: String? {
        switch self {
        case .weakPassword:
            return "Password must be at least 6 characters"
        case .emptyFields:
            return "All fields are required"
        case .userNotFound:
            return "No account found with this email."
        case .wrongPassword:
            return "Incorrect password"
        case .userAlreadyExists:
            return "User already exists"
        case .emailAlreadyInUse:
            return "This email is already registered."
        case .invalidEmail:
            return "Invalid email format."
        case .credentialExpired:
            return "Session expired. Please login again."
        case .unknown(let message):
            return message
        }
    }
}
