//
//  NetworkMonitor.swift
//  DemoOffLineDBApp
//
//

import Network
import Foundation

final class NetworkMonitor: ObservableObject {

    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Network")

    @Published var isConnected = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
               print("Network Status --> \(path.status)")
                print("Status:", path.status)
                print("Is Expensive:", path.isExpensive)
                print("Interfaces:", path.availableInterfaces)
                if path.usesInterfaceType(.wifi) {
                    print("Connected via Wi-Fi")
                } else if path.usesInterfaceType(.cellular) {
                    print("Connected via Cellular")
                }
                self?.isConnected = ((path.status == .satisfied) ? true : false)
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}
