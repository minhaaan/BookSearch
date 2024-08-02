//
//  ImageCacheTests.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/2/24.
//

@testable import BookSearch
import XCTest

final class ImageCacheTests: XCTestCase {

  var imageCache: ImageCache!
  var diskStorage: DiskStorageMock!
  var memoryStorage: MemoryStorageMock!
  var memoryStorageMissMock: MemoryStorageMissMock!

  let url = URL(string: "https://google.com")!
  let image = UIImage(systemName: "flame")!

  override func setUpWithError() throws {
    diskStorage = DiskStorageMock()
    memoryStorage = MemoryStorageMock()
    memoryStorageMissMock = MemoryStorageMissMock()
    imageCache = ImageCacheImpl(diskStorage: diskStorage, memoryStorage: memoryStorage)
  }

  override func tearDownWithError() throws {
  }

  func test_store() {
    // GIVEN

    // WHEN
    imageCache.store(url: url, image: image)

    // THEN
    _ = XCTWaiter.wait(for: [expectation(description: "")], timeout: 1.0)
    XCTAssert(memoryStorage.storeUrlValueCalled)
    XCTAssert(memoryStorage.storeUrlValueCallsCount == 1)
    XCTAssert(diskStorage.storeUrlValueCalled)
    XCTAssert(diskStorage.storeUrlValueCallsCount == 1)
  }

  func test_value_memory_hit() {
    // GIVEN

    // WHEN
    let sut = imageCache.value(url: url)

    // THEN
    XCTAssert(sut != nil)
  }

  func test_value_disk_hit() {
    // GIVEN
    imageCache = ImageCacheImpl(diskStorage: diskStorage, memoryStorage: memoryStorageMissMock)

    // WHEN
    let sut = imageCache.value(url: url)

    // THEN
    XCTAssert(sut != nil)
    XCTAssert(memoryStorageMissMock.storeUrlValueCalled)
  }

  func test_value_miss() {
    // GIVEN
    imageCache = ImageCacheImpl(diskStorage: DiskStorageMissMock(), memoryStorage: MemoryStorageMissMock())

    // WHEN
    let sut = imageCache.value(url: url)

    // THEN
    XCTAssert(sut == nil)
  }


}
