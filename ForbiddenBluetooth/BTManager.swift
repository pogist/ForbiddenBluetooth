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
  func manager(_ manager: BTManager, didRemoveDevice device: Device)
  func managerPowerDidChange(_ manager: BTManager)
  func managerAvailabilityDidChange(_ manager: BTManager)
}

class BTManager {
  weak var delegate: BTManagerDelegate?

  private var observers: [String: NSObjectProtocol] = [:]
  private let bluetoothManager = BluetoothManagerHelper.shared()

  var isEnabled: Bool {
    return bluetoothManager.enabled()
  }

  var isAvailable: Bool {
    return bluetoothManager.available()
  }

  var isScanning: Bool {
    return bluetoothManager.deviceScanningInProgress()
  }

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
          case BTManager.deviceRemoved:
            if let device = Device(notification: notification) {
              self.delegate?.manager(self, didRemoveDevice: device)
            }
          case BTManager.powerChanged:
            self.delegate?.managerPowerDidChange(self)
          case BTManager.availabilityChanged:
            self.delegate?.managerAvailabilityDidChange(self)
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

  func scan(enabled: Bool) {
    bluetoothManager.setDeviceScanningEnabled(enabled)
    if enabled {
      bluetoothManager.resetDeviceScanning()
      bluetoothManager.scan(forServices: 0xFFFFFFFF)
    }
  }

  func setEnabled(_ enabled: Bool) {
    bluetoothManager.setEnabled(enabled)
  }
}
