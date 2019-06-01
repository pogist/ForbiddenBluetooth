//
//  BTManager+Notification.swift
//  ForbiddenBluetooth
//
//  Created by Murilo da Paixão on 31/05/19.
//  Copyright © 2019 Murilo Paixão. All rights reserved.
//

import Foundation

extension BTManager {
  static let powerChanged            = Notification.Name("BluetoothPowerChangedNotification")
  static let availabilityChanged     = Notification.Name("BluetoothAvailabilityChangedNotification")
  static let deviceDiscovered        = Notification.Name("BluetoothDeviceDiscoveredNotification")
  static let deviceRemoved           = Notification.Name("BluetoothDeviceRemovedNotification")
  static let connectabilityChanged   = Notification.Name("BluetoothConnectabilityChangedNotification")
  static let deviceUpdated           = Notification.Name("BluetoothDeviceUpdatedNotification")
  static let discoveryStateChanged   = Notification.Name("BluetoothDiscoveryStateChangedNotification")
  static let deviceConnectSuccess    = Notification.Name("BluetoothDeviceConnectSuccessNotification")
  static let connectionStatusChanged = Notification.Name("BluetoothConnectionStatusChangedNotification")
  static let deviceDisconnectSuccess = Notification.Name("BluetoothDeviceDisconnectSuccessNotification")

  static let allNotifications: [Notification.Name] = [
    BTManager.powerChanged,
    BTManager.availabilityChanged,
    BTManager.deviceDiscovered,
    BTManager.deviceRemoved,
    BTManager.connectabilityChanged,
    BTManager.deviceUpdated,
    BTManager.discoveryStateChanged,
    BTManager.deviceConnectSuccess,
    BTManager.connectionStatusChanged,
    BTManager.deviceDisconnectSuccess
  ]
}
