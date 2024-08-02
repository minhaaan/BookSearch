//
//  CacheMock.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/2/24.
//

@testable import BookSearch
import UIKit

// MARK: - ImageCacheMock -

final class ImageCacheMock: ImageCache {

  // MARK: - store

  var storeUrlImageCallsCount = 0
  var storeUrlImageCalled: Bool {
    storeUrlImageCallsCount > 0
  }
  func store(url: URL, image: UIImage) {
    storeUrlImageCallsCount += 1
  }

  // MARK: - value

  var valueUrlCallsCount = 0
  var valueUrlCalled: Bool {
    valueUrlCallsCount > 0
  }
  func value(url: URL) -> UIImage? {
    valueUrlCallsCount += 1
    return UIImage(systemName: "flame")
  }
}

final class ImageCacheMissMock: ImageCache {
  // MARK: - store

  var storeUrlImageCallsCount = 0
  var storeUrlImageCalled: Bool {
    storeUrlImageCallsCount > 0
  }
  func store(url: URL, image: UIImage) {
    storeUrlImageCallsCount += 1
  }

  // MARK: - value

  var valueUrlCallsCount = 0
  var valueUrlCalled: Bool {
    valueUrlCallsCount > 0
  }
  func value(url: URL) -> UIImage? {
    valueUrlCallsCount += 1
    return nil
  }
}

final class DiskStorageMock: DiskStorage {
  var storeUrlValueCallsCount = 0
  var storeUrlValueCalled: Bool {
    storeUrlValueCallsCount > 0
  }
  func store(url: URL, value: UIImage) {
    storeUrlValueCallsCount += 1
  }

  // MARK: - value

  var valueUrlCallsCount = 0
  var valueUrlCalled: Bool {
    valueUrlCallsCount > 0
  }
  func value(url: URL) -> UIImage? {
    return UIImage(systemName: "flame")
  }

  // MARK: - isCached

  var isCachedUrlCallsCount = 0
  var isCachedUrlCalled: Bool {
    isCachedUrlCallsCount > 0
  }
  func isCached(url: URL) -> Bool {
    isCachedUrlCallsCount += 1
    return true
  }
}

final class DiskStorageMissMock: DiskStorage {
  var storeUrlValueCallsCount = 0
  var storeUrlValueCalled: Bool {
    storeUrlValueCallsCount > 0
  }
  func store(url: URL, value: UIImage) {
    storeUrlValueCallsCount += 1
  }

  // MARK: - value

  var valueUrlCallsCount = 0
  var valueUrlCalled: Bool {
    valueUrlCallsCount > 0
  }
  func value(url: URL) -> UIImage? {
    return nil
  }

  // MARK: - isCached

  var isCachedUrlCallsCount = 0
  var isCachedUrlCalled: Bool {
    isCachedUrlCallsCount > 0
  }
  func isCached(url: URL) -> Bool {
    isCachedUrlCallsCount += 1
    return false
  }
}

final class MemoryStorageMock: MemoryStorage {
  var cache = NSCache<NSString, UIImage>()

  var storeUrlValueCallsCount = 0
  var storeUrlValueCalled: Bool {
    storeUrlValueCallsCount > 0
  }
  func store(url: URL, value: UIImage) {
    storeUrlValueCallsCount += 1
  }

  // MARK: - value

  var valueUrlCallsCount = 0
  var valueUrlCalled: Bool {
    valueUrlCallsCount > 0
  }
  func value(url: URL) -> UIImage? {
    return UIImage(systemName: "flame")
  }

  // MARK: - isCached

  var isCachedUrlCallsCount = 0
  var isCachedUrlCalled: Bool {
    isCachedUrlCallsCount > 0
  }
  func isCached(url: URL) -> Bool {
    isCachedUrlCallsCount += 1
    return true
  }
}

final class MemoryStorageMissMock: MemoryStorage {
  var cache = NSCache<NSString, UIImage>()

  var storeUrlValueCallsCount = 0
  var storeUrlValueCalled: Bool {
    storeUrlValueCallsCount > 0
  }
  func store(url: URL, value: UIImage) {
    storeUrlValueCallsCount += 1
  }

  // MARK: - value

  var valueUrlCallsCount = 0
  var valueUrlCalled: Bool {
    valueUrlCallsCount > 0
  }
  func value(url: URL) -> UIImage? {
    return nil
  }

  // MARK: - isCached

  var isCachedUrlCallsCount = 0
  var isCachedUrlCalled: Bool {
    isCachedUrlCallsCount > 0
  }
  func isCached(url: URL) -> Bool {
    isCachedUrlCallsCount += 1
    return false
  }
}



