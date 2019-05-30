//
//  BluetoothSwitchView.swift
//  ForbiddenBluetooth
//
//  Created by Murilo Paixão on 30/05/19.
//  Copyright © 2019 Murilo Paixão. All rights reserved.
//

import UIKit

protocol BluetoothSwitchViewDelegate: class {
  func bluetoothSwitchView(_ bluetoothSwitchView: BluetoothSwitchView, didChangeValueOf bluetoothSwitch: UISwitch)
}

class BluetoothSwitchView: UIView {
  weak var delegate: BluetoothSwitchViewDelegate?

  lazy var descriptionLabel: UILabel = {
    let label = UILabel()

    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)

    return label
  }()

  lazy var bluetoothSwitch: UISwitch = {
    return UISwitch()
  }()

  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [descriptionLabel, bluetoothSwitch])

    stackView.alignment = .leading
    stackView.distribution = .equalCentering
    stackView.axis = .horizontal
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)

    descriptionLabel
      .centerYAnchor
      .constraint(equalTo: stackView.centerYAnchor)
      .isActive = true

    return stackView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }

  convenience init(description: String, isSwitchOn: Bool) {
    self.init(frame: .zero)

    descriptionLabel.text = description
    bluetoothSwitch.setOn(isSwitchOn, animated: false)
  }

  private func setupView() {
    addSubview(stackView)
    bluetoothSwitch.addTarget(self, action: #selector(didChangeSwitchValue(_:)), for: .valueChanged)
  }

  @objc func didChangeSwitchValue(_ switch: UISwitch) {
    delegate?.bluetoothSwitchView(self, didChangeValueOf: `switch`)
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()

    if let superview = superview {
      let height = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
      let frame = CGRect(x: 0, y: 0, width: superview.bounds.width, height: height)

      // Both `self` and stackView should always have the same frame, otherwise there's a chance
      // of `self` becoming unable to receive any user interaction whatsoever. In other words,
      // if `self` is initialized with a .zero frame that never changes, then it won't be able
      // to receive/forward any gesture or user interaction down to the responder chain.
      self.frame = frame
      stackView.frame = frame
    }
  }
}
