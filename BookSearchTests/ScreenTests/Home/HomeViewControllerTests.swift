//
//  HomeViewControllerTests.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/3/24.
//

@testable import BookSearch
import XCTest

final class BookSearchViewControllerTests: XCTestCase {

  var viewController: HomeViewController!
  var router: HomeRouterMock!
  var presentableListener: HomePresentableListenerMock!

  override func setUp() {
    viewController = HomeViewController(listView: HomeListView())
    router = HomeRouterMock()
    presentableListener = HomePresentableListenerMock()
    viewController.router = router
    viewController.listener = presentableListener
  }

  override func tearDown() {
    viewController.listener = nil
    viewController = nil
    presentableListener = nil
  }

  func test_routeDetail() async {
    // GIVEN
    let dummyIsbn = "12312312"

    // WHEN
    await viewController.routeDetail(isbn13: dummyIsbn)

    // THEN
    XCTAssert(router.presentDetailCallsCount == 1)
  }

}
