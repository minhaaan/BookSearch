//
//  DiskStorage.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

protocol DiskStorage: ImageCacheStorage {
}

final class DiskStorageImpl: DiskStorage {

  // MARK: Props

  private let fileManager: FileManager = FileManager.default
  
  /// 파일시스템 불필요한 조회를 줄이고, 캐시 여부 빠르게 확인하기 위해 추가
  private var maybeCached: Set<String>?
  private let maybeCachedCheckingQueue = DispatchQueue(label: "maybeCachedCheckingQueue")
  private var directoryURL: URL

  // MARK: init

  init() {
    directoryURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    setupCacheChecking()
  }

  // MARK: Methods

  func store(url: URL, value: UIImage) {
    let data = value.jpegData(compressionQuality: 1.0) // Data 타입으로 변환
    do {
      // 쓰기 작업
      try data?.write(to: directoryURL.appendingPathComponent(url.lastPathComponent, isDirectory: false))
    } catch {
    }
    maybeCachedCheckingQueue.async {
      self.maybeCached?.insert(url.lastPathComponent)
    }
  }

  func value(url: URL) -> UIImage? {
    let fileURL: URL = directoryURL.appendingPathComponent(url.lastPathComponent, isDirectory: false) // 저장 URL
    let filePath = fileURL.path

    let isCached = maybeCachedCheckingQueue.sync {
      return maybeCached?.contains(url.lastPathComponent) ?? true
    }
    guard isCached else { return nil }
    guard fileManager.fileExists(atPath: filePath) else { return nil }

    do {
      let data = try Data(contentsOf: fileURL)
      let image = UIImage(data: data)
      return image
    } catch {
      return nil
    }
  }

  func isCached(url: URL) -> Bool {
    return value(url: url) != nil
  }
  
  /// 전체 제거
  func removeAll() {
    try? fileManager.removeItem(at: directoryURL)
  }
  
  /// 파일시스템에 저장된 파일 미리 로드해 maybeCached에 저장
  private func setupCacheChecking() {
    maybeCachedCheckingQueue.async {
      do {
        self.maybeCached = Set()
        try self.fileManager.contentsOfDirectory(atPath: self.directoryURL.path).forEach {
          self.maybeCached?.insert($0)
        }
      } catch {
        self.maybeCached = nil
      }
    }
  }

}
