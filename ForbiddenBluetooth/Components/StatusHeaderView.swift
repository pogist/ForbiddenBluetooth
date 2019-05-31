//
//  StatusHeaderView.swift
//  ForbiddenBluetooth
//
//  Created by Murilo Paixão on 30/05/19.
//  Copyright © 2019 Murilo Paixão. All rights reserved.
//

import UIKit

class StatusHeaderView: UIView {
  lazy var statusLabel: UILabel = UILabel()

  lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .gray)

    activityIndicator.color = .black
    activityIndicator.hidesWhenStopped = true
    activityIndicator.startAnimating()

    return activityIndicator
  }()

  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [activityIndicator, statusLabel])

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

  convenience init(statusMessage: String) {
    self.init(frame: .zero)
    statusLabel.text = statusMessage
  }

  private func setupView() {
    addSubview(stackView)
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()

    let size = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    let frame = CGRect(origin: self.frame.origin, size: size)

    self.frame = frame
    stackView.frame = frame
  }

  func setVisibility(_ visibility: Bool) {
    stackView.isHidden = !visibility
  }
}
