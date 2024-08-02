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

  var detailIsbnCallsCount = 0
  var detailIsbnCalled: Bool {
    detailIsbnCallsCount > 0
  }
  var detailError: Error?
  var dummyDetailDTO: DetailDTO = DetailDTO(
    error: "0",
    title: "title",
    subtitle: "subtitle",
    authors: "authors",
    publisher: "asda",
    language: "asd",
    isbn10: "asd",
    isbn13: "asd",
    pages: "a",
    year: "",
    rating: "",
    desc: "",
    price: "",
    image: "https://google.com",
    url: "https://google.com",
    pdf: ["123": "https:google.com"]
  )
  var detailIsbnClosure: () -> Void = {}

  func detail(isbn: String) async throws -> DetailDTO {
    detailIsbnCallsCount += 1
    detailIsbnClosure()
    if let detailError { throw detailError}
    return dummyDetailDTO
  }
}
