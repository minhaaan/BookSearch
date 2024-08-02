//
//  HomeInteractor.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

protocol HomePresentable: AnyObject {
  func routeDetail(isbn13: String) async
}

final class HomeInteractor: HomePresentableListener, HomeListListener {

  // MARK: Properties

  weak var presenter: HomePresentable?

  // MARK: init

  init() {}

  // MARK: Method

  func routeDetail(isbn13: String) async {
    await presenter?.routeDetail(isbn13: isbn13)
  }

}

