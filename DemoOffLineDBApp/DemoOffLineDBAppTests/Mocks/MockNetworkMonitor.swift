//
//  MockNetworkMonitor.swift
//  DemoOffLineDBAppTests
//
//

import Combine

final class MockNetworkMonitor: NetworkMonitorProtocol {
    var isConnected: Bool = true

    // Must publish immediately so SyncManager doesn't wait forever
    var isConnectedPublisher: AnyPublisher<Bool, Never> {
        Just(isConnected)
            .eraseToAnyPublisher()
    }
}
