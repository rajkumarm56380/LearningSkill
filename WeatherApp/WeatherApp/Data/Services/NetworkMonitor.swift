//
//  NetworkMonitor.swift
//  WeatherApp
//
//

import Combine
import Foundation
import Network

final class NetworkMonitor {
    @Published private(set) var isConnected: Bool = false

    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
