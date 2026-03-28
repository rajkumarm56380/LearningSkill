//
//  AthuError.swift
//  DemoOffLineDBApp
//
//

import Foundation

enum AuthError: LocalizedError {

    case emailAlreadyInUse
    case invalidEmail
    case wrongPassword
    case userNotFound
    case invalidCredential
    case networkError
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .emailAlreadyInUse:
            return "Email already in use"
        case .invalidEmail:
            return "Invalid email format"
        case .wrongPassword:
            return "Wrong password"
        case .userNotFound:
            return "User not found. Please sign up"
        case .invalidCredential:
            return "Invalid or expired credentials"
        case .networkError:
            return "No internet connection"
        case .unknown(let msg):
            return msg
        }
    }
}

enum AuthErrorOld: LocalizedError, Equatable {

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
            print("AuthError errorDescription message ==> \(message)")
            return "Something went wrong. Please try again."
        }
    }
}

