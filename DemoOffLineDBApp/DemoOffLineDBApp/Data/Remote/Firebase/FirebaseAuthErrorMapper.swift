//
//  FirebaseAuthErrorMapper.swift
//  DemoOffLineDBApp
//

import FirebaseAuth

struct FirebaseAuthErrorMapper {

    static func mapFirebaseError(_ error: Error) -> AuthError {

        let nsError = error as NSError

        guard let code = AuthErrorCode(rawValue: nsError.code) else {
            return .unknown(error.localizedDescription)
        }

        switch code {

        case .emailAlreadyInUse:
            return .emailAlreadyInUse

        case .invalidEmail:
            return .invalidEmail

        case .wrongPassword:
            return .wrongPassword

        case .userNotFound:
            return .userNotFound

        case .invalidCredential:
            return .invalidCredential

        case .networkError:
            return .networkError

        default:
            return .unknown(error.localizedDescription)
        }
    }
}

