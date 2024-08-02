//
//  Array+Extension.swift
//  BookSearch
//
//  Created by 최민한 on 8/3/24.
//

import Foundation

extension Array {
  /// Out of Bounds 방지
  /// index 벗어날 시 nil return
  /// 정상적인 값이면 optional(Element) return
  subscript (safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
}
