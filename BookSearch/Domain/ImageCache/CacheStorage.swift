//
//  CacheStorage.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

protocol ImageCacheStorage {
  func store(url: URL, value: UIImage)
  func value(url: URL) -> UIImage?
  func isCached(url: URL) -> Bool
}
