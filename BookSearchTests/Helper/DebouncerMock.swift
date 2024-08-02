//
//  DebouncerMock.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/2/24.
//

@testable import BookSearch
import Foundation

final class DebouncerMock: Debouncer {
  func debounce(delay: TimeInterval, task: @escaping () async -> Void) async {
    await task()
  }
}
