//
//  CheckNetwork.swift
//  idusHomework
//
//  Created by miori Lee on 2022/08/17.
//

import Foundation
import Network

final class CheckNetwork {
    static let shared = CheckNetwork()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false

    private init() {
        monitor = NWPathMonitor()
    }

    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }

    public func stopMonitoring() {
        monitor.cancel()
    }
}

//reference: https://velog.io/@minji0801/iOS-Swift-Network-연결-확인하기
