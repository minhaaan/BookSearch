//
//  MemoryStorageTests.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/2/24.
//

@testable import BookSearch
import XCTest

final class MemoryStorageTests: XCTestCase {

  var memoryStorage: MemoryStorageImpl!
  let dummyURL = URL(string: "https://google.com")!

  override func setUpWithError() throws {
    memoryStorage = MemoryStorageImpl()
  }

  override func tearDownWithError() throws {
  }

  func test_cache_hit() {
    // GIVEN

    // WHEN
    memoryStorage.store(url: dummyURL, value: UIImage(systemName: "flame")!)

    // THEN
    XCTAssert(memoryStorage.value(url: dummyURL) != nil)
  }

  func test_cache_miss() {
    // GIVEN

    // WHEN

    // THEN
    XCTAssert(memoryStorage.value(url: dummyURL) == nil)
    XCTAssert(memoryStorage.isCached(url: dummyURL) == false)
  }
}
