//
//  ImageLoaderMock.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/3/24.
//

@testable import BookSearch
import UIKit

final class ImageLoaderMock: ImageLoadable {

  var returnImage: UIImage?
  var loadImageCallsCount = 0
  func loadImage(from url: URL) async throws -> UIImage {
    loadImageCallsCount += 1
    return returnImage ?? UIImage(systemName: "flame")!
  }

}
