//
//  DebouncerTests.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/2/24.
//

@testable import BookSearch
import XCTest

final class DebouncerTests: XCTestCase {

  var debouncer: DebouncerImpl!
  var exp: XCTestExpectation!

  override func setUpWithError() throws {
    debouncer = DebouncerImpl()
    exp = .init()
  }

  override func tearDownWithError() throws {
  }

  func test_딜레이후_실행() async {
    // GIVEN
    var executionCount = 0 // 실행횟수
    let delay: TimeInterval = 0.5

    // WHEN
    await debouncer.debounce(delay: delay) {
      executionCount += 1
      self.exp.fulfill()
    }

    // THEN
    await fulfillment(of: [exp], timeout: delay + 1.0)
    XCTAssert(executionCount == 1)
  }

  func test_이전작업취소() async {
    // GIVEN
    var executionCount = 0 // 실행 횟수
    let delay: TimeInterval = 0.5

    // WHEN
    await debouncer.debounce(delay: delay) {
      executionCount += 1
    }

    // 첫번째 작업 취소해야함
    await debouncer.debounce(delay: delay) {
      executionCount += 1
      self.exp.fulfill()
    }

    // THEN
    await fulfillment(of: [exp], timeout: delay + 1.0)
    XCTAssert(executionCount == 1)
  }


}
