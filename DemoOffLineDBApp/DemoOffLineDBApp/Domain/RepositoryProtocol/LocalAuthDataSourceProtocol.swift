//
//  LocalAuthDataSourceProtocol.swift
//  DemoOffLineDBApp
//
//

protocol LocalAuthDataSourceProtocol {
    func saveUser(_ user: User)
    func fetchLoggedInUser() -> LocalUser?
    func logout()
}
