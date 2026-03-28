//
//  FirebaseAuthService.swift
//  DemoOffLineDBApp
//

import FirebaseAuth
import Foundation

final class FirebaseAuthService: AuthServiceProtocol {

    private var auth: Auth {
        Auth.auth()
    }
    
    func login(email: String, password: String) async throws -> User {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)

            return User(
                id: UUID(uuidString: result.user.uid) ?? UUID(),
                name: result.user.displayName ?? "guest user",
                email: result.user.email ?? "",
                password: "",
                isLoggedIn: true
            )
        } catch {
            throw FirebaseAuthErrorMapper.mapFirebaseError(error)
        }
    }
    
    func signup(user: User) async throws -> User {
        do {
            let result = try await Auth.auth().createUser(withEmail: user.email, password: user.password)
            let name = await setDisplayName(user.name)
            return User(
                id: UUID(uuidString: result.user.uid) ?? UUID(),
                name: name  ?? "guest user",
                email: user.email,
                password: "",
                isLoggedIn: true
            )
        } catch {
            throw FirebaseAuthErrorMapper.mapFirebaseError(error)
        }
    }

    func setDisplayName(_ name: String) async -> String? {
        guard let user = Auth.auth().currentUser else { return nil }
        let request = user.createProfileChangeRequest()
        request.displayName = name

        return await withCheckedContinuation { continuation in
            request.commitChanges { error in
                if let error = error {
                    print("Error:", error)
                    continuation.resume(returning: nil)
                } else {
                    print("Display name updated")
                    continuation.resume(returning: name)
                }
            }
        }
    }

    func logout() async throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw FirebaseAuthErrorMapper.mapFirebaseError(error)
        }
    }
    
    // Auth State Stream
    func observeAuthState() -> AsyncStream<User?> {
        
        AsyncStream { continuation in
            
            let handle = Auth.auth().addStateDidChangeListener { _, user in
                if let user = user {
                    continuation.yield(

                        User(
                            id: UUID(uuidString: user.uid) ?? UUID(),
                            name: Auth.auth().currentUser?.displayName ?? "",
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
