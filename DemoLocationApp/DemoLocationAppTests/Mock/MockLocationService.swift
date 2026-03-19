//
//  MockLocationService.swift
//  DemoLocationAppTests
//
//

import Combine
import CoreLocation

final class MockLocationService: LocationServiceProtocol {

    private let subject = PassthroughSubject<CLLocationCoordinate2D, Never>()

    var locationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> {
        subject.eraseToAnyPublisher()
    }

    func requestLocation() {
        let coordinates = [
                    CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946),
                    CLLocationCoordinate2D(latitude: 12.9720, longitude: 77.5950),
                    CLLocationCoordinate2D(latitude: 12.9730, longitude: 77.5960)
                ]

        // simulate async location
        for (index, coord) in coordinates.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index)) {
                self.subject.send(coord)
            }
        }
    }
}
