//
//  HomeInteractorTests.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/3/24.
//

@testable import BookSearch
import XCTest

final class HomeInteractorTests: XCTestCase {

  var interactor: HomeInteractor!
  var presenter: HomePresenterMock!

  override func setUpWithError() throws {
    interactor = HomeInteractor()
    presenter = HomePresenterMock()
    interactor.presenter = presenter
  }

  override func tearDownWithError() throws {
  }

  func test_routeDetail_호출했을때_presenter의_routeDetail_호출되는가() async {
    // GIVEN

    // WHEN
    await interactor.routeDetail(isbn13: "123213")

    // THEN
    XCTAssert(presenter.routeDetailCallsCount == 1)
  }

}
