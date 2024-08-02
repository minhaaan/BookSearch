//
//  HomeRouterTests.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/3/24.
//

@testable import BookSearch
import XCTest

final class HomeRouterTests: XCTestCase {

  var router: HomeRouter!
  var detailBuilder: DetailBuilderMock!

  override func setUpWithError() throws {
    detailBuilder = DetailBuilderMock()
    router = HomeRouter(detailBuilder: detailBuilder)
  }

  override func tearDownWithError() throws {
  }
  
  func test_presentDetail() {
    // GIVEN

    // WHEN
    router.presentDetail(isbn13: "")

    // THEN
    XCTAssert(detailBuilder.buildCallsCount == 1)
  }


}
