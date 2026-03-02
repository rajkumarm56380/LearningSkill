//
//  SearchRepositoryProtocol.swift
//  DemoCombine
//
//  Created by Apple on 02/03/26.
//

import Combine

protocol SearchRepositoryProtocol {
    func searchUsers(query: String) -> AnyPublisher<[User], Error>
}
