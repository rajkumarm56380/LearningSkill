//
//  VenueAPIService.swift
//  VenuesApp
//
//

import Combine
import Foundation

protocol VenueAPIServiceProtocol {
    func fetchVenues() -> AnyPublisher<[Venue], Error>
}

final class VenueAPIService: VenueAPIServiceProtocol {

    func fetchVenues() -> AnyPublisher<[Venue], Error> {
        guard let url = URL(string: "\(APIEndPoint.endpoint.rawValue)q=\("food")\(APIParam.param.rawValue)") else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("User-Agent", forHTTPHeaderField: "TestingLocation/(rajkumar.m56380@gmail.com)")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    switch (response as! HTTPURLResponse).statusCode {
                    case (400...499):
                        throw APIError.internalError((response as! HTTPURLResponse).statusCode)
                    default:
                        throw APIError.serverError((response as! HTTPURLResponse).statusCode)
                    }
                }
                return data
            }
            .mapError { $0 as! APIError }
            //.map(\.data)
            .decode(type: [Venue].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
