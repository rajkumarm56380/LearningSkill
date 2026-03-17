//
//  SessionManager.swift
//  DBDemo
//
//
//

import Combine

// MARK: - SessionManager
final class SessionManager: ObservableObject {
    static let shared = SessionManager()
    @Published var isLoggedIn: Bool = false
}
