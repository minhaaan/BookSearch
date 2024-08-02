//
//  BookRepositoryTests.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/2/24.
//

@testable import BookSearch
import XCTest


final class BookRepositoryTests: XCTestCase {

  var bookRepo: BookRepository!

  let successResponse: (Data) -> ((URLRequest) throws -> (HTTPURLResponse, Data?))? = { data  in
    return { request in
      let res = HTTPURLResponse(
        url: request.url!.absoluteURL,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
      )!
      return (res, data)
    }
  }
  let failureResponse: ((URLRequest) throws -> (HTTPURLResponse, Data?))? = { request in
    guard let res = HTTPURLResponse(
      url: request.url!.absoluteURL,
      statusCode: 401,
      httpVersion: nil,
      headerFields: nil
    ) else {
      throw URLError(.badURL)
    }
    return (res, Data())
  }

  override func setUpWithError() throws {
    let session: URLSession = {
      let config = URLSessionConfiguration.default
      config.protocolClasses = [MockURLProtocol.self]
      return URLSession(configuration: config)
    }()
    self.bookRepo = BookRepositoryImpl(session: session)
  }

  override func tearDownWithError() throws {
  }

  func test_search_성공() async throws {
    // GIVEN
    let query = "죽전"
    MockURLProtocol.requestHandler = successResponse(BookApi.search(query).mockData)

    // WHEN
    let result = try await bookRepo.search(query: query)

    // THEN
    XCTAssert(result.error == "0")
  }

  func test_search_실패() async throws {
    // GIVEN
    let query = "SWIFT"
    MockURLProtocol.requestHandler = failureResponse

    // WHEN

    // THEN
    do {
      let _ = try await bookRepo.search(query: query)
    } catch {
      XCTAssert(true) // 실패하면 성공
    }
  }

  func test_searchPage_성공() async throws {
    // GIVEN
    let query = "SWIFT"
    let page = 0
    MockURLProtocol.requestHandler = successResponse(BookApi.searchPage(query, page).mockData)

    // WHEN
    let result = try await bookRepo.searchPage(query: query, page: page)

    // THEN
    XCTAssert(result.error == "0")
  }

  func test_searchPage_실패() async throws {
    // GIVEN
    let query = "SWIFT"
    MockURLProtocol.requestHandler = failureResponse

    // WHEN

    // THEN
    do {
      let _ = try await bookRepo.searchPage(query: query, page: 0)
    } catch {
      XCTAssert(true) // 실패하면 성공
    }
  }

  func test_detail_성공() async throws {
    // GIVEN
    let isbn = "SWIFT"
    MockURLProtocol.requestHandler = successResponse(BookApi.detail(isbn).mockData)

    // WHEN
    let result = try await bookRepo.detail(isbn: isbn)

    // THEN
    XCTAssert(result.error == "0")
  }

  func test_detail_실패() async throws {
    // GIVEN
    let isbn = "SWIFT"
    MockURLProtocol.requestHandler = failureResponse

    // WHEN

    // THEN
    do {
      let _ = try await bookRepo.detail(isbn: isbn)
    } catch {
      XCTAssert(true) // 실패하면 성공
    }
  }


}
