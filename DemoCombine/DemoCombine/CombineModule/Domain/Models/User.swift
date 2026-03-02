//
//  User.swift
//  DemoCombine
//
//  Created by user on 02/03/26.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let email: String
}
