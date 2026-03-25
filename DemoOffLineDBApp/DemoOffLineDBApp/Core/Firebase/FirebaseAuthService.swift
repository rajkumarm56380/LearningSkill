//
//  FirebaseAuthService.swift
//  DemoOffLineDBApp
//

import Combine
import FirebaseAuth
import Foundation

final class FirebaseAuthService: AuthServiceProtocol {

    private var auth: Auth {
        Auth.auth()   // ✅ only accessed when needed
    }
    
    func login(email: String, password: String) async throws -> User {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        
        return User(
            id: UUID(uuidString: result.user.uid) ?? UUID(),
            name: result.user.displayName ?? "",
            email: result.user.email ?? "",
            password: "",
            isLoggedIn: true
        )
    }
    
    func signup(user: User) async throws -> User {
        let result = try await Auth.auth().createUser(withEmail: user.email, password: user.password)
        
        return User(
            id: UUID(uuidString: result.user.uid) ?? UUID(),
            name: user.name,
            email: result.user.email ?? "",
            password: "",
            isLoggedIn: true
        )
    }
    
    func logout() async throws {
        try Auth.auth().signOut()
    }
    
    // Auth State Stream
    func observeAuthState() -> AsyncStream<User?> {
        
        AsyncStream { continuation in
            
            let handle = Auth.auth().addStateDidChangeListener { _, user in
                if let user = user {
                    continuation.yield(
                        User(
                            id: UUID(uuidString: user.uid) ?? UUID(),
                            name: user.displayName ?? "",
                            email: user.email ?? "",
                            password: "",
                            isLoggedIn: true
                        )
                    )
                } else {
                    continuation.yield(nil)
                }
            }
            
            continuation.onTermination = { _ in
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    }
}
