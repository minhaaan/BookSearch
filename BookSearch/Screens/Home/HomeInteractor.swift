//
//  HomeInteractor.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

protocol HomePresentable: AnyObject {
}

final class HomeInteractor: HomePresentableListener, HomeListListener {

  // MARK: Properties

  weak var presenter: HomePresentable?

  // MARK: init

  init() {}

  // MARK: Method

}

