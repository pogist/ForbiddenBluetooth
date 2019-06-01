//
//  BTManager.swift
//  ForbiddenBluetooth
//
//  Created by Murilo da Paixão on 31/05/19.
//  Copyright © 2019 Murilo Paixão. All rights reserved.
//

import Foundation

protocol BTManagerDelegate: class {
  func manager(_ manager: BTManager, didDiscoverDevice device: Device)
}

class BTManager {
  weak var delegate: BTManagerDelegate?

  private var discoveredDevices: Set<Device> = Set()
  private var observers: [String: NSObjectProtocol] = [:]
  private let bluetoothManager = BluetoothManagerHelper.shared()

  init(delegate: BTManagerDelegate) {
    self.delegate = delegate

    for notificationName in BTManager.allNotifications {
      let observer = NotificationCenter.default.addObserver(
        forName: notificationName,
        object: nil,
        queue: OperationQueue.main,
        using: { [weak self] notification in
          guard let self = self else { return }

          switch notification.name {
          case BTManager.deviceDiscovered:
            if let device = Device(notification: notification) {
              self.delegate?.manager(self, didDiscoverDevice: device)
            }
          default:
            break
          }
        })

      observers[notificationName.rawValue] = observer
    }
  }

  deinit {
    for notificationName in observers.keys {
      if let observer = observers[notificationName] {
        NotificationCenter.default.removeObserver(observer)
      }
    }
  }

  func startScan() {
    bluetoothManager.setDeviceScanningEnabled(true)
    bluetoothManager.scan(forServices: 0xFFFFFFFF)
  }

  func stopScan() {
    bluetoothManager.setDeviceScanningEnabled(false)
  }
}