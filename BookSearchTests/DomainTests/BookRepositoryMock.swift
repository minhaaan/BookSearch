//
//  BookRepositoryMock.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/2/24.
//

@testable import BookSearch
import Foundation

// MARK: - BookRepositoryMock -

final class BookRepositoryMock: BookRepository {

  // MARK: - search

  let dummySearchDTO = SearchDTO(
    error: "0",
    total: "77",
    page: "1",
    books: [
      .init(title: "1", subtitle: "2", isbn13: "3", price: "4", image: "5", url: "6")
    ]
  )
  var searchQueryCallsCount = 0
  var searchQueryCalled: Bool {
    searchQueryCallsCount > 0
  }
  var searchQueryReturningValue: SearchDTO?
  var searchQueryClosure: () -> Void = {}

  func search(query: String) async throws -> SearchDTO {
    searchQueryCallsCount += 1
    searchQueryClosure()
    return searchQueryReturningValue ?? dummySearchDTO
  }

  // MARK: - searchPage

  var searchPageQueryPageCallsCount = 0
  var searchPageQueryPageCalled: Bool {
    searchPageQueryPageCallsCount > 0
  }
  var searchPageQueryPageClosure: () -> Void = {}

  func searchPage(query: String, page: Int) throws -> SearchDTO {
    searchPageQueryPageCallsCount += 1
    searchPageQueryPageClosure()
    return dummySearchDTO
  }

  // MARK: - detail

  var detailIsbnThrowableError: Error?
  var detailIsbnCallsCount = 0
  var detailIsbnCalled: Bool {
    detailIsbnCallsCount > 0
  }
  var detailIsbnReceivedIsbn: String?
  var detailIsbnReceivedInvocations: [String] = []
  var detailIsbnReturnValue: DetailDTO!
  var detailIsbnClosure: ((String) throws -> DetailDTO)?

  func detail(isbn: String) throws -> DetailDTO {
    detailIsbnCallsCount += 1
    if let error = detailIsbnThrowableError {
      throw error
    }
    detailIsbnReceivedIsbn = isbn
    detailIsbnReceivedInvocations.append(isbn)
    return try detailIsbnClosure.map({ try $0(isbn) }) ?? detailIsbnReturnValue
  }
}
