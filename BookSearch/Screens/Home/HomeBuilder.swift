//
//  HomeBuilder.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

struct HomeDependency {
  let repository: BookRepository
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
      repository: depdendency.repository
    )
    let homeListBuilder = HomeListBuilder(dependency: homeListDependency, listener: interactor)

    let viewController = HomeViewController(
      listView: homeListBuilder.build()
    )
    viewController.listener = interactor
    interactor.presenter = viewController

    return viewController
  }

}
