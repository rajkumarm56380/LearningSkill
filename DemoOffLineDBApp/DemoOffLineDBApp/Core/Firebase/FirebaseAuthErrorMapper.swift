//
//  FirebaseAuthErrorMapper.swift
//  DemoOffLineDBApp
//
 
//

import FirebaseAuth

struct FirebaseAuthErrorMapper {

    static func map(_ error: Error) -> AuthError {

        let nsError = error as NSError

        guard let code = AuthErrorCode(rawValue: nsError.code) else {
            return .unknown(nsError.localizedDescription)
        }

        switch code {

        case .emailAlreadyInUse:
            return .emailAlreadyInUse

        case .invalidEmail:
            return .invalidEmail

        case .weakPassword:
            return .weakPassword

        case .wrongPassword:
            return .wrongPassword

        case .userNotFound:
            return .userNotFound

        case .invalidCredential:
            return .credentialExpired

//        case .networkError:
//            return .unknown(nsError.localizedDescription)

        default:
            return .unknown(nsError.localizedDescription)
        }
    }
}

