//
//  ImageLoader.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

final class ImageLoader {

  enum ImageLoaderError: Error {
    case convertUIImageError // Data -> UIImage 타입변환 불가
  }

  private let session: URLSession
  private let imageCache: ImageCache

  init(
    session: URLSession = URLSession(configuration: .ephemeral),
    imageCache: ImageCache = ImageCacheImpl()
  ) {
    self.session = session
    self.imageCache = imageCache
  }

  func loadImage(from url: URL) async throws -> UIImage {
    // 캐싱된 이미지가 있다면 return
    if let cachedImage = imageCache.value(url: url) {
      return cachedImage
    }

    let (data, _) = try await session.data(from: url) // 이미지 데이터 다운로드
    guard let image = UIImage(data: data) else { // UIImage 변환
      throw ImageLoaderError.convertUIImageError
    }
    storeImage(url: url, image: image) // 캐시에 이미지 저장
    return image
  }

  /// 캐시에 이미지 저장
  private func storeImage(url: URL, image: UIImage?) {
    guard let image else { return }
    imageCache.store(url: url, image: image)
  }

}
