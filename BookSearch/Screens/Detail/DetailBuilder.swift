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
    let viewController = UIViewController()
    return viewController
  }

}
