//
//  APIEndPoint.swift
//  VenuesApp
//
//  Created by Apple on 14/03/26.
//

import Foundation

enum APIEndPoint: String {
    case endpoint = "https://nominatim.openstreetmap.org/search?"
}

enum APIParam: String {
    case param = "&limit=19&format=json&addressdetails=1"
}

enum APIError: Error {
    case invalidRequestError(String)
    case transportError(Error)
    case internalError(_ statusCode: Int)
    case serverError(_ statusCode: Int)
}
