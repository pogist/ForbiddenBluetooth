//
//  ScanningStatusView.swift
//  ForbiddenBluetooth
//
//  Created by Murilo Paixão on 30/05/19.
//  Copyright © 2019 Murilo Paixão. All rights reserved.
//

import UIKit

class ScanningStatusView: UIView {
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

  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [activityIndicator, scanningLabel])

    stackView.alignment = .center
    stackView.axis = .horizontal
    stackView.distribution = .fillProportionally
    stackView.spacing = 8

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

  convenience init() {
    self.init(frame: .zero)
  }

  private func setupView() {
    let size = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    let frame = CGRect(origin: self.frame.origin, size: size)

    self.frame = frame
    stackView.frame = frame

    addSubview(stackView)
  }

  func setScanning(_ scanningStatus: Bool) {
    stackView.isHidden = !scanningStatus
  }
}
