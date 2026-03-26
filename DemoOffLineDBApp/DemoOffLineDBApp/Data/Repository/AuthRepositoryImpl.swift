//
//  AuthRepositoryImpl.swift
//  DemoOffLineDBApp
//
//

import Combine
import Foundation

final class AuthRepository: AuthRepositoryProtocol {    

    private let remote: AuthServiceProtocol
    private let local: LocalAuthDataSource
    private let network: NetworkMonitor
    private var cancellables = Set<AnyCancellable>()

    init(remote: AuthServiceProtocol,
         local: LocalAuthDataSource,
         network: NetworkMonitor) {
        self.remote = remote
        self.local = local
        self.network = network
    }

    // LOGIN
    func login(email: String, password: String) async throws -> User {

        if network.isConnected {
            let user = try await remote.login(email: email, password: password)
            local.saveUser(user)
            return user

        } else {
            // OFFLINE LOGIN
            guard let localUser = local.fetchLoggedInUser() else {
                throw AuthError.unknown("No offline session found")
            }

            return User(
                id: UUID(uuidString: localUser.id) ?? UUID(),
                name: "",
                email: localUser.email,
                password: "",
                isLoggedIn: true)
        }
    }

    func signup(user: User) async throws -> User {
        if network.isConnected {
           let user = try await remote.signup(user: user)
            return user

        } else {
            // OFFLINE LOGIN
            guard let localUser = local.fetchLoggedInUser() else {
                throw AuthError.unknown("No offline session found")
            }
            let user = User(
                id: UUID(uuidString: localUser.id) ?? UUID(),
                name: "",
                email: localUser.email,
                password: "",
                isLoggedIn: true)

            return user
        }
    }

    // AUTO LOGIN (APP START)
    func getCurrentUser() -> User? {
        if let localUser = local.fetchLoggedInUser() {
            return User(
                id: UUID(uuidString: localUser.id) ?? UUID(),
                name: "",
                email: localUser.email,
                password: "",
                isLoggedIn: true
            )
        }

        return nil
    }

    // LOGOUT
    func logout() async throws {
        try await remote.logout()
        local.logout()
    }
}

/*
final class AuthRepositoryImpl: AuthRepositoryProtocol {

    private let storage: UserStorageProtocol

    init(storage: UserStorageProtocol) {
        self.storage = storage
    }

    func signup(user: User) -> AnyPublisher<Bool, Error> {
        let users = storage.fetchUsers()

        //  Check if user already exists (case-insensitive email)
        if users.contains(where: {
            $0.email.lowercased() == user.email.lowercased()
        }) {
            return Fail(error: AuthError.userAlreadyExists)
                .eraseToAnyPublisher()
        }

        // Save user
        storage.saveUser(user)

        return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func login(email: String, password: String) -> AnyPublisher<User?, Error> {

        guard storage.isUserExist(email: email) else {
            return Fail(error: AuthError.userNotFound)
                .eraseToAnyPublisher()
        }

        //  Find matching user
        guard let user = storage.fetchUsers().first(where: {
            $0.email.lowercased() == email.lowercased() &&
            $0.password == password
        }) else {
            return Fail(error: AuthError.invalidEmail)
                .eraseToAnyPublisher()
        }
        // Return valid user
        return Just(user)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func logout() throws {
//        let firebaseAuth = Auth.auth()
//        do {
//          try firebaseAuth.signOut()
//        } catch let signOutError as NSError {
//          print("Error signing out: %@", signOutError)
//        }
    }
}

*/
