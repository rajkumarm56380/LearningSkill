//
//  NetworkMonitor.swift
//  DemoOffLineDBApp
//
//

import Network
import Foundation

final class NetworkMonitor: ObservableObject {

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Network")

    @Published var isConnected = true

    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
