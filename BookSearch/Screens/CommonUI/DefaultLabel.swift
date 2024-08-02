//
//  DefaultLabel.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

final class DefaultLabel: UILabel {

  // MARK: Properties

  // MARK: init

  init() {
    super.init(frame: .zero)

    self.font = .systemFont(ofSize: 20)
    self.numberOfLines = 0
    self.textAlignment = .center
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Method

}
