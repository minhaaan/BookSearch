//
//  BookApi.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import Foundation

enum BookApi {
  case search(String)
  case searchPage(String, Int)
  case detail(String)
}

extension BookApi: TargetType {
  var baseURL: String {
    "https://api.itbook.store/1.0"
  }

  var path: String {
    switch self {
    case let .search(query):
      return "/search/\(query)"
    case let .searchPage(query, page):
      return "/search/\(query)/\(page)"
    case let .detail(isbn13):
      return "/books/\(isbn13)"
    }
  }
}
