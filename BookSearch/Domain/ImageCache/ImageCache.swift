//
//  ImageCache.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

protocol ImageCache {
  func store(url: URL, image: UIImage)
  func value(url: URL) -> UIImage?
}

final class ImageCacheImpl: ImageCache {

  private let diskStorage: DiskStorage
  private let memoryStorage: MemoryStorage
  private let ioQueue: DispatchQueue

  init(
    diskStorage: DiskStorage = DiskStorageImpl(),
    memoryStorage: MemoryStorage = MemoryStorageImpl()
  ) {
    self.diskStorage = diskStorage
    self.memoryStorage = memoryStorage
    self.ioQueue = DispatchQueue(label: "ioQueue")
  }

  func store(url: URL, image: UIImage) {
    memoryStorage.store(url: url, value: image)

    ioQueue.async {
      self.diskStorage.store(url: url, value: image)
    }
  }

  func value(url: URL) -> UIImage? {
    // 메모리 캐시부터 체크
    if let image = memoryStorage.value(url: url) {
      return image
    }

    // 디스크 체크, 있으면 메모리 캐시에 올리기.
    if let image = diskStorage.value(url: url) {
      memoryStorage.store(url: url, value: image)
      return image
    }

    return nil
  }


}

