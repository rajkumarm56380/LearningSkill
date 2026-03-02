//
//  NetworkService.swift
//  DemoCombine
//
//  Created by user on 02/03/26.
//
import Combine
import Foundation

protocol NetworkServiceProtocol {
    func fetchUsers(query: String) -> AnyPublisher<[User], Error>
}

final class NetworkService: NetworkServiceProtocol {

    func fetchUsers(query: String) -> AnyPublisher<[User], Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .subscribe(on: DispatchQueue.global(qos: .background)) // background thread
            .receive(on: DispatchQueue.main) // UI thread
            .eraseToAnyPublisher()
    }
}
