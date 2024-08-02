//
//  ImageLoaderTests.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/2/24.
//

@testable import BookSearch
import XCTest

final class ImageLoaderTests: XCTestCase {

  var imageLoader: ImageLoader!
  var imageCacheMissMock: ImageCacheMissMock!
  let dummyURL = URL(string: "https://google.com")!

  override func setUp() async throws {
    let session: URLSession = {
      let config = URLSessionConfiguration.default
      config.protocolClasses = [MockURLProtocol.self]
      return URLSession(configuration: config)
    }()
    imageCacheMissMock = ImageCacheMissMock()
    imageLoader = ImageLoader(
      session: session,
      imageCache: imageCacheMissMock
    )
  }

  override func tearDown() async throws {
  }

  // 캐시 hit
  func test_loadImage_cache_hit() async throws {
    // GIVEN
    let imageCache = ImageCacheMock()
    imageLoader = ImageLoader(session: .shared, imageCache: imageCache)

    // WHEN
    let _ = try await imageLoader.loadImage(from: dummyURL)

    // THEN
    XCTAssert(imageCache.valueUrlCalled) // 캐시 조회했는가
    XCTAssert(true) // 이미지 불러오기 성공
  }

  // 캐시 미스
  func test_loadImage_cache_miss() async throws {
    // GIVEN
    MockURLProtocol.requestHandler = { request in
      let res = HTTPURLResponse(url: self.dummyURL.absoluteURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
      let data = UIImage(systemName: "flame")!.jpegData(compressionQuality: 0.5)
      return (res, data)
    }

    // WHEN
    let _ = try await imageLoader.loadImage(from: dummyURL)

    // THEN
    // 캐시 미스되어서 이미지 다운로드 했을때 이미지 저장해야함
    XCTAssert(imageCacheMissMock.storeUrlImageCallsCount == 1)
  }

}
