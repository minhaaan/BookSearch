//
//  HomeBuilder.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

struct HomeDependency {
  let repository: BookRepository
  let imageLoader: ImageLoader
  let detailBuilder: DetailBuildable
}

final class HomeBuilder {

  // MARK: Properties

  let depdendency: HomeDependency

  // MARK: init

  init(depdendency: HomeDependency) {
    self.depdendency = depdendency
  }

  // MARK: Method

  func build() -> UIViewController {
    let interactor = HomeInteractor()

    let homeListDependency = HomeListViewDependency(
      repository: depdendency.repository,
      imageLoader: depdendency.imageLoader
    )
    let homeListBuilder = HomeListBuilder(dependency: homeListDependency, listener: interactor)

    let router = HomeRouter(detailBuilder: depdendency.detailBuilder)
    let viewController = HomeViewController(
      listView: homeListBuilder.build()
    )
    viewController.listener = interactor
    viewController.router = router
    router.viewController = viewController
    interactor.presenter = viewController

    return viewController
  }

}
