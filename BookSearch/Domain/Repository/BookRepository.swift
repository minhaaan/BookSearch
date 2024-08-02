//
//  BookRepository.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import Foundation

protocol BookRepository {
  func search(query: String) async throws -> SearchDTO
  func searchPage(query: String, page: Int) async throws -> SearchDTO
  func detail(isbn: String) async throws -> DetailDTO
}

final class BookRepositoryImpl: BookRepository {

  var provider: Provider<BookApi>

  init(session: URLSession = URLSession.shared) {
    self.provider = Provider<BookApi>(session: session)
  }

  /// /search/\(query)
  func search(query: String) async throws -> SearchDTO {
    try await provider.request(.search(query))
  }
  
  /// /search/\(query)/\(page)
  func searchPage(query: String, page: Int) async throws -> SearchDTO {
    try await provider.request(.searchPage(query, page))
  }
  
  /// /books/\(isbn)
  func detail(isbn: String) async throws -> DetailDTO {
    try await provider.request(.detail(isbn))
  }
}

