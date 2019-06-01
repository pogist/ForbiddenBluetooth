//
//  Device.swift
//  ForbiddenBluetooth
//
//  Created by Murilo da Paixão on 31/05/19.
//  Copyright © 2019 Murilo Paixão. All rights reserved.
//

import Foundation

struct Device: Hashable, Equatable, CustomStringConvertible {
  let address: String
  let name: String
  let type: Int
  let batteryLevel: Int
  let supportsBatteryLevel: Bool

  init?(notification: Notification) {
    guard let bluetoothDevice = BluetoothDeviceHelper.device(from: notification) else {
      return nil
    }

    self.address = bluetoothDevice.address() as! String // swiftlint:disable:this force_cast
    self.name = bluetoothDevice.name() as! String // swiftlint:disable:this force_cast
    self.type = Int(bluetoothDevice.type())
    self.batteryLevel = Int(bluetoothDevice.batteryLevel())
    self.supportsBatteryLevel = bluetoothDevice.supportsBatteryLevel()
  }

  var description: String {
    return "\(name) (\(address))"
  }

  static func == (lhs: Device, rhs: Device) -> Bool {
    return lhs.address == rhs.address
  }
}
