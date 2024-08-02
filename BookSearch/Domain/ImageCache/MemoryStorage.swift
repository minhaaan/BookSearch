//
//  MemoryStorage.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

protocol MemoryStorage: ImageCacheStorage {
  var cache: NSCache<NSString, UIImage> { get }
}

final class MemoryStorageImpl: MemoryStorage {
  let cache = NSCache<NSString, UIImage>()
  let lock = NSLock()

  init() {
    self.cache.countLimit = 100 // 최대개수
    self.cache.totalCostLimit = 1024 * 1024 * 100 // 100MB
  }

  func store(url: URL, value: UIImage) {
    lock.lock(); defer { lock.unlock() }
    cache.setObject(value, forKey: url.lastPathComponent as NSString)
  }

  func value(url: URL) -> UIImage? {
    return cache.object(forKey: url.lastPathComponent as NSString)
  }

  func isCached(url: URL) -> Bool {
    return cache.object(forKey: url.lastPathComponent as NSString) != nil
  }
}

