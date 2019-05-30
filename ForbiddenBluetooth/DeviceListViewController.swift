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

  lazy var scanningLabel: UILabel = {
    let label = UILabel(frame: .zero)

    label.text = "Scanning..."
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()

  lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .gray)

    activityIndicator.color = .black
    activityIndicator.hidesWhenStopped = true
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false

    activityIndicator.startAnimating()

    return activityIndicator
  }()

  lazy var scanningHeader: UIStackView = {
    let headerView = UIStackView(arrangedSubviews: [activityIndicator, scanningLabel])

    headerView.alignment = .center
    headerView.axis = .horizontal
    headerView.distribution = .fillProportionally
    headerView.spacing = 8

    return headerView
  }()

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
    title = "Bluetooth"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.titleView = scanningHeader
  }

  func setupTableView() {
    tableView.tableHeaderView = tableHeaderView
    tableView.tableFooterView = UIView()
  }
}

extension DeviceListViewController: BluetoothSwitchViewDelegate {
  func bluetoothSwitchView(_ bluetoothSwitchView: BluetoothSwitchView, didChangeValueOf bluetoothSwitch: UISwitch) {
    if bluetoothSwitch.isOn {
      bluetoothSwitchView.descriptionLabel.text = "bluetooth is on"
    } else {
      bluetoothSwitchView.descriptionLabel.text = "bluetooth is off"
    }
  }
}
