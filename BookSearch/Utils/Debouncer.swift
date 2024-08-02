//
//  Debouncer.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import Foundation

protocol Debouncer {
  func debounce(delay: TimeInterval, task: @escaping () async -> Void) async
}

actor DebouncerImpl: Debouncer {
  private var currentTask: Task<Void, Never>?

  func debounce(delay: TimeInterval, task: @escaping () async -> Void) {
    // 실행 중인 Task 있으면 취소
    currentTask?.cancel()

    // Task 생성
    currentTask = Task {
      // delay로 받은 시간 동안 대기
      try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))

      // Task가 취소되지 않았으면 실행
      if !Task.isCancelled {
        await task()
      }
    }
  }
}




