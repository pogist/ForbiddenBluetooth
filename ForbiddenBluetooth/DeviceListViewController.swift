//
//  DeviceListViewController.swift
//  ForbiddenBluetooth
//
//  Created by Murilo Paixão on 30/05/19.
//  Copyright © 2019 Murilo Paixão. All rights reserved.
//

import UIKit

class DeviceListViewController: UITableViewController {

  // MARK: UI components

  lazy var scanningStatus: StatusHeaderView = StatusHeaderView(statusMessage: "Scanning...")

  lazy var tableHeaderView: BluetoothSwitchView = {
    let bluetoothSwitchView = BluetoothSwitchView(description: "bluetooth is on", isSwitchOn: true)
    bluetoothSwitchView.delegate = self

    return bluetoothSwitchView
  }()

  // MARK: UIViewController lifecycle

  var manager: BTManager!

  var devices: [Device] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupNavigationBar()
    setupTableView()

    manager = BTManager(delegate: self)
    manager.setEnabled(true)
  }

  func setupNavigationBar() {
    title = "Devices"
    navigationController?.navigationBar.prefersLargeTitles = true

    scanningStatus.setVisibility(false)
    navigationItem.titleView = scanningStatus
  }

  func setupTableView() {
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    tableView.tableHeaderView = tableHeaderView
    tableView.tableFooterView = UIView()
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return devices.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
    cell.accessoryType = .disclosureIndicator

    let device = devices[indexPath.row]

    cell.textLabel?.text = device.name
    cell.detailTextLabel?.text = device.address

    return cell
  }
}

extension DeviceListViewController: BluetoothSwitchViewDelegate {
  func bluetoothSwitchView(_ bluetoothSwitchView: BluetoothSwitchView, didChangeValueOf bluetoothSwitch: UISwitch) {
    manager.setEnabled(bluetoothSwitch.isOn)
  }
}

extension DeviceListViewController: BTManagerDelegate {
  func managerAvailabilityDidChange(_ manager: BTManager) {
    manager.scan(enabled: manager.isAvailable)
    scanningStatus.setVisibility(manager.isAvailable)
  }

  func managerPowerDidChange(_ manager: BTManager) {
    manager.scan(enabled: manager.isEnabled)

    if !manager.isEnabled {
      devices.removeAll()
    }

    scanningStatus.setVisibility(manager.isEnabled)
    tableHeaderView.descriptionLabel.text = "bluetooth is \(manager.isEnabled ? "on" : "off")"
  }

  func manager(_ manager: BTManager, didDiscoverDevice device: Device) {
    if !devices.contains(device) {
      devices.append(device)
    }
  }

  func manager(_ manager: BTManager, didRemoveDevice device: Device) {
    devices.removeAll(where: { $0 == device })
  }
}
