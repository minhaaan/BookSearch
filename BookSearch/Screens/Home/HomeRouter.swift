//
//  HomeRoutable.swift
//  BookSearch
//
//  Created by 최민한 on 8/3/24.
//

import UIKit

final class HomeRouter: HomeRoutable {

  weak var viewController: UIViewController?
  let detailBuilder: DetailBuildable

  init(detailBuilder: DetailBuildable) {
    self.detailBuilder = detailBuilder
  }

  func presentDetail(isbn13: String) {
    let detailViewController = detailBuilder.build(isbn13: isbn13)
    detailViewController.modalPresentationStyle = .popover
    viewController?.present(detailViewController, animated: true)
  }

}
