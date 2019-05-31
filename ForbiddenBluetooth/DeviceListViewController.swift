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

  override func viewDidLoad() {
    super.viewDidLoad()

    setupNavigationBar()
    setupTableView()
  }

  func setupNavigationBar() {
    title = "Devices"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.titleView = scanningStatus
  }

  func setupTableView() {
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    tableView.tableHeaderView = tableHeaderView
    tableView.tableFooterView = UIView()
  }
}

extension DeviceListViewController: BluetoothSwitchViewDelegate {
  func bluetoothSwitchView(_ bluetoothSwitchView: BluetoothSwitchView, didChangeValueOf bluetoothSwitch: UISwitch) {
    bluetoothSwitchView.descriptionLabel.text = "bluetooth is \(bluetoothSwitch.isOn ? "on" : "off")"
    scanningStatus.setVisibility(bluetoothSwitch.isOn)
  }
}
