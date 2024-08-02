//
//  HomeListViewTests.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/2/24.
//

@testable import BookSearch
import XCTest

final class HomeListViewTests: XCTestCase {

  var listView: HomeListView!
  var presentableListener: HomeListPresentableListenerMock!
  var exp: XCTestExpectation!

  override func setUpWithError() throws {
    presentableListener = HomeListPresentableListenerMock()
    listView = HomeListView()
    listView.listener = presentableListener
    exp = XCTestExpectation()
  }

  override func tearDownWithError() throws {
  }

  @MainActor
  func test_검색어바뀌었을떄_updateQuery_호출하는가() async {
    // GIVEN
    let query = "123"
    presentableListener.updateQueryQueryClosure = { _ in
      self.exp.fulfill()
    }

    // WHEN
    listView.searchBar(.init(), textDidChange: query)

    // THEN
    await fulfillment(of: [exp], timeout: 0.1)
    XCTAssert(presentableListener.updateQueryQueryCallsCount == 1)
  }
}


