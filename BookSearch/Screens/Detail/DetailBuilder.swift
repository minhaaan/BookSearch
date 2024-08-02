//
//  BookDetailBuilder.swift
//  BookSearch
//
//  Created by 최민한 on 8/3/24.
//

import UIKit

struct DetailDependency {
  let repository: BookRepository
  let imageLoader: ImageLoader
}

protocol DetailBuildable {
  func build(isbn13: String) -> UIViewController
}

final class DetailBuilder: DetailBuildable {

  let dependency: DetailDependency

  init(dependency: DetailDependency) {
    self.dependency = dependency
  }

  func build(isbn13: String) -> UIViewController {
    let viewController = DetailViewController()
    let interactor = DetailInteractor(
      isbn: isbn13,
      bookRepo: dependency.repository,
      imageLoader: dependency.imageLoader
    )
    let router = DetailRouter()

    viewController.listener = interactor
    viewController.router = router
    router.viewController = viewController
    interactor.presenter = viewController

    return viewController
  }

}
