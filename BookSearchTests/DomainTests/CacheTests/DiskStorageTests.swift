//
//  DiskStorageTests.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/2/24.
//

@testable import BookSearch
import XCTest

final class DiskStorageTests: XCTestCase {

  var diskStorage: DiskStorageImpl!
  let dummyURL = URL(string: "https://google.com/SWIFT")!

  override func setUpWithError() throws {
    diskStorage = DiskStorageImpl()
  }

  override func tearDownWithError() throws {
  }

  func test_cache_hit() {
    // GIVEN
    diskStorage.store(url: dummyURL, value: UIImage(systemName: "flame")!)

    // WHEN

    // THEN
    XCTAssert(diskStorage.value(url: dummyURL) != nil)
  }

  func test_cache_miss() {
    // GIVEN
    diskStorage.removeAll()

    // WHEN

    // THEN
    XCTAssert(diskStorage.value(url: dummyURL) == nil)
    XCTAssert(diskStorage.isCached(url: dummyURL) == false)
  }

}
