//
//  BookDetailBuilder.swift
//  BookSearch
//
//  Created by 최민한 on 8/3/24.
//

import UIKit

enum Detail {}

extension Detail {
  struct Dependency {
    let repository: BookRepository
    let imageLoader: ImageLoader
  }


  protocol Buildable {
    func build(isbn13: String) -> UIViewController
  }

  final class Builder: Buildable {

    let dependency: Detail.Dependency

    init(dependency: Dependency) {
      self.dependency = dependency
    }

    func build(isbn13: String) -> UIViewController {
      let viewController = Detail.ViewController()
      let interactor = Detail.Interactor(
        isbn: isbn13,
        bookRepo: dependency.repository,
        imageLoader: dependency.imageLoader
      )
      let router = Detail.Router()

      viewController.listener = interactor
      viewController.router = router
      router.viewController = viewController
      interactor.presenter = viewController

      return viewController
    }
  }
}

