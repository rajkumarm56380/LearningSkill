//
//  AuthState.swift
//  DemoOffLineDBApp
//
//


enum AuthState {
    case loading
    case authenticated(User)
    case unauthenticated
}
