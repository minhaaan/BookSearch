//
//  HomeListInteractorTests.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/2/24.
//

@testable import BookSearch
import XCTest

final class HomeListInteractorTests: XCTestCase {

  var interactor: HomeListInteractor!
  var bookRepo: BookRepositoryMock!
  var presenter: HomeListPresentableMock!
  var exp: XCTestExpectation!

  override func setUpWithError() throws {
    exp = XCTestExpectation()
    bookRepo = BookRepositoryMock()
    presenter = HomeListPresentableMock()
    interactor = HomeListInteractor(
      bookRepo: bookRepo,
      imageLoader: ImageLoader(),
      debouncer: DebouncerMock()
    )
    interactor.presenter = presenter
  }

  override func tearDownWithError() throws {
  }

  func test_updateQuery() async {
    // GIVEN
    let query = "123"
    bookRepo.searchQueryClosure = {
      self.exp.fulfill()
    }

    // WHEN
    await interactor.updateQuery(query: query)

    // THEN
    await fulfillment(of: [exp], timeout: 1.0)
    XCTAssert(bookRepo.searchQueryCallsCount == 1) // BookRepo searchQuery 호출했는지 확인
    XCTAssert(interactor.books.count == 1) // books 업데이트 됐는지 확인
    XCTAssert(presenter.updateListViewCalled) // CollectioView 업데이트 확인
  }

  /// 빈문자열로 호출했을때 books가 빈배열이여야함
  func test_updateQuery_빈문자열() async {
    // GIVEN
    interactor.books = [.init(title: "", subtitle: "", isbn13: "", price: "", image: "", url: "")]
    let query = ""

    // WHEN
    await interactor.updateQuery(query: query)

    // THEN
    XCTAssert(bookRepo.searchQueryCallsCount == 0) // API 호출하지 않아야함
    XCTAssert(interactor.books.count == 0) // books 빈배열 체크
    XCTAssert(presenter.updateListViewCalled) // CollectioView 업데이트 확인
  }

  func test_willDisplay_호출했을때_다음페이지_조회() async {
    // GIVEN
    let query = "SWIFT"

    // WHEN
    await interactor.updateQuery(query: query)
    await interactor.willDisplay(query: query, indexPath: IndexPath(row: 0, section: 0))

    // THEN
    XCTAssert(bookRepo.searchPageQueryPageCallsCount == 1) // API 호출 검사
  }

  @MainActor
  func test_willDisplay_페이지네이션_조건아닐때() async {
    // GIVEN
    let query = "SWIFT"
    let searchDTOMock: SearchDTO = SearchDTO(
      error: "0",
      total: "3",
      page: "1",
      books: [
        .init(title: "", subtitle: "", isbn13: "", price: "", image: "", url: ""),
        .init(title: "", subtitle: "", isbn13: "", price: "", image: "", url: ""),
        .init(title: "", subtitle: "", isbn13: "", price: "", image: "", url: ""),
        .init(title: "", subtitle: "", isbn13: "", price: "", image: "", url: ""),
      ]
    )
    bookRepo.searchQueryReturningValue = searchDTOMock

    // WHEN
    await interactor.updateQuery(query: query)
    await interactor.willDisplay(query: query, indexPath: IndexPath(row: 0, section: 0))

    // THEN
    XCTAssert(bookRepo.searchPageQueryPageCallsCount == 0)
  }


}
