//
//  HomeMock.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/3/24.
//

@testable import BookSearch
import UIKit

// MARK: HomeRouterMock

final class HomeRouterMock: HomeRoutable {
  var presentDetailCallsCount = 0
  func presentDetail(isbn13: String) {
    presentDetailCallsCount += 1
  }
}

// MARK: HomePresentableListenerMock

final class HomePresentableListenerMock: HomePresentableListener {
}

// MARK: HomePresenterMock

final class HomePresenterMock: HomePresentable {
  var routeDetailCallsCount = 0
  func routeDetail(isbn13: String) async {
    routeDetailCallsCount += 1
  }
}

// MARK: DetailBuilderMock

final class DetailBuilderMock: Detail.Buildable {
  var buildCallsCount = 0
  func build(isbn13: String) -> UIViewController {
    buildCallsCount += 1
    return UIViewController()
  }
}
