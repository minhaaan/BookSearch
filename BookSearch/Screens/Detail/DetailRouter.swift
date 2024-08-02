//
//  DetailRouter.swift
//  BookSearch
//
//  Created by 최민한 on 8/3/24.
//

import UIKit

final class DetailRouter: DetailRoutable {

  weak var viewController: UIViewController?

  /// 조회실패 UIAlertViewController를 띄운다.
  /// 확인 누르면 ViewController Dismiss
  @MainActor
  func showErrorAlert() async {
    let alertViewController = UIAlertController(
      title: "조회실패",
      message: "다시 시도해주세요",
      preferredStyle: .alert
    )
    let dismissAction = UIAlertAction(title: "확인", style: .default) { [weak self]  _ in
      self?.viewController?.dismiss(animated: true)
    }
    alertViewController.addAction(dismissAction)
    viewController?.present(alertViewController, animated: true)
  }

}
