//
//  PasswordRule.swift
//  DemoOffLineDBApp
//
//

import Foundation

struct PasswordRule: ValidationRule {

    let password: String

    init(_ password: String) {
        self.password = password
    }

    func validate() -> String? {
        
        if password.isEmpty {
            return "Password is required"
        }
        
        if password.count < 6 {
            return "Password must be at least 6 characters"
        }
        
        return nil

//        let pattern =
//        #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$"#
//        
//        let isValid = NSPredicate(format: "SELF MATCHES %@", pattern)
//            .evaluate(with: password)
//        
//        return isValid ? nil : "Password must include uppercase, lowercase, and number"
    }
}
