//
//  HomeListInteractor.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

protocol HomeListListener: AnyObject {
}

protocol HomeListPresentable: AnyObject {
  func updateListView()
}

final class HomeListInteractor: HomeListPresentableListener {

  struct PageData {
    /// 현재 페이지
    let curPage: Int?
    /// 전체 페이지
    let totalPage: Int?
  }

  // MARK: Properties

  weak var presenter: HomeListPresentable?

  private let bookRepo: BookRepository

  private let debouncer: Debouncer
  private var pageData: PageData?

  let imageLoader: ImageLoader
  var books: [SearchDTO.Book] = []

  // MARK: init

  init(
    bookRepo: BookRepository,
    imageLoader: ImageLoader,
    debouncer: Debouncer = DebouncerImpl()
  ) {
    self.bookRepo = bookRepo
    self.imageLoader = imageLoader
    self.debouncer = debouncer
  }

  // MARK: Method

  /// 검색어 변경됨
  /// - Parameter query: 검색어
  @MainActor
  func updateQuery(query: String) async {
    await debouncer.debounce(delay: 0.5) { [weak self] in
      guard let self = self else { return }
      // query 바뀌었으니 books 데이터 초기화
      self.books = []
      self.pageData = nil
      self.presenter?.updateListView()

      // query가 비어있다면 API 요청하지않음
      guard query.isEmpty == false else { return }

      // API 요청
      do {
        let books = try await self.bookRepo.search(query: query)
        self.books = books.books
        self.pageData = PageData(curPage: Int(books.page), totalPage: Int(books.total))
        presenter?.updateListView()
      } catch {
      }
    }
  }
  
  /// 셀 표시될때 호출되는 함수
  /// - Parameters:
  ///   - query: 현재 검색어
  ///   - indexPath: IndexPath
  func willDisplay(query: String, indexPath: IndexPath) async {
    guard
      let curPage = pageData?.curPage, // 현재 페이지
      let totalPage = pageData?.totalPage, // 전체 페이지
      curPage <= (totalPage / 10) + 1,
      indexPath.row == books.count - 1
    else {
      return
    }

    // 다음 페이지 조회
    try? await fetchNextPage(query: query, nextPage: curPage + 1)
  }
  
  /// 다음 페이지 조회
  /// - Parameters:
  ///   - query: 검색어
  ///   - nextPage: 다음 페이지
  private func fetchNextPage(query: String, nextPage: Int) async throws {
    guard pageData?.curPage != nextPage else { return } // 조회할 페이지가 현재 페이지와 같지 않아야함

    let books = try await bookRepo.searchPage(query: query, page: nextPage)
    pageData = PageData(curPage: Int(books.page), totalPage: Int(books.total)) // 페이지 데이터 업데이트

    Task { @MainActor in
      self.books += books.books // 책 추가
      presenter?.updateListView()
    }
  }

}



