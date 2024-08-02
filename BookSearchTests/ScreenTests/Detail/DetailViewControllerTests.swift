//
//  DetailViewControllerTests.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/3/24.
//

@testable import BookSearch
import XCTest

final class DetailViewControllerTests: XCTestCase {

  var viewController: DetailViewController!
  var router: DetailRouterMock!
  var listener: DetailPresentableListenerMock!

  override func setUpWithError() throws {
    router = DetailRouterMock()
    listener = DetailPresentableListenerMock()
    viewController = DetailViewController()
    viewController.router = router
    viewController.listener = listener
  }

  override func tearDownWithError() throws {
  }

  func test_viewDidAppear_호출됐을때_listener_fetchDetailData_한번만호출하는가() async {
    // GIVEN

    // WHEN
    // 두번호출
    await viewController.viewDidAppear(true)
    await viewController.viewDidAppear(true)

    // THEN
    XCTAssert(listener.fetchDetailDataCallsCount == 1) // 한번만 호출되어야함
  }

  func test_showFetchErrorAlert_호출했을때_router의_showErrorAlert_호출하는가() async {
    // GIVEN

    // WHEN
    await viewController.showFetchErrorAlert()

    // THEN
    XCTAssert(router.showErrorAlertCallsCount == 1)
  }

}
