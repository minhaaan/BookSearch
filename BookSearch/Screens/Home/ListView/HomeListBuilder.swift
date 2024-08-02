//
//  HomeListViewBuilder.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

struct HomeListViewDependency {
  let repository: BookRepository
}

final class HomeListBuilder {

  let dependency: HomeListViewDependency
  let listener: HomeListListener

  init(
    dependency: HomeListViewDependency,
    listener: HomeListListener
  ) {
    self.dependency = dependency
    self.listener = listener
  }

  func build() -> UIView {
    let listView = HomeListView()
    let interactor = HomeListInteractor(
      bookRepo: dependency.repository
    )
    interactor.presenter = listView
    
    listView.listener = interactor

    return listView
  }

}
