//
//  HomeListInteractor.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

protocol HomeListListener: AnyObject {
  func routeDetail(isbn13: String) async
}

protocol HomeListPresentable: AnyObject {
  func updateListView()
}

final class HomeListInteractor: HomeListPresentableListener {

  private struct PageData {
    let query: String // 검색어
    let curPage: Int? // 현재 페이지
    let totalPage: Int? // 전체 페이지
  }

  // MARK: Properties

  weak var listener: HomeListListener?
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
    // 디바운스 0.5초
    await debouncer.debounce(delay: 0.5) { [weak self] in
      guard let self = self else { return }
      // query 바뀌었으니 books 데이터 초기화
      self.clearBooksData()

      // 공백제거한 query가 비어있다면 API 요청하지않음
      guard query.replacingOccurrences(of: " ", with: "").isEmpty == false else { return }

      // API 요청
      do {
        let search = try await self.bookRepo.search(query: query)
        self.books = search.books
        self.pageData = PageData(
          query: query,
          curPage: Int(search.page),
          totalPage: Int(search.total)
        )
        presenter?.updateListView()
      } catch {
      }
    }
  }
  
  /// 셀 선택됨
  /// - Parameter indexPath: 선택된 셀의 IndexPath
  func didSelectItemAt(indexPath: IndexPath) async {
    guard let isbn13 = books[safe: indexPath.row]?.isbn13 else { return }
    await listener?.routeDetail(isbn13: isbn13)
  }
  
  /// 책 데이터 초기화
  private func clearBooksData() {
    books = []
    pageData = nil
    presenter?.updateListView()
  }

  // MARK: PageNation

  /// 셀 표시될때 호출되는 함수
  /// - Parameters:
  ///   - query: 현재 검색어
  ///   - indexPath: IndexPath
  func willDisplay(indexPath: IndexPath) async {
    guard
      let pageData,
      let curPage = pageData.curPage, // 현재 페이지
      let totalPage = pageData.totalPage, // 전체 페이지
      curPage <= (totalPage / 10) + 1,
      indexPath.row == books.count - 1
    else {
      return
    }

    // 다음 페이지 조회
    try? await fetchNextPage(nextPage: curPage + 1)
  }
  
  /// 다음 페이지 조회
  /// - Parameters:
  ///   - query: 검색어
  ///   - nextPage: 다음 페이지
  private func fetchNextPage(nextPage: Int) async throws {
    guard
      pageData?.curPage != nextPage, // 조회할 페이지가 현재 페이지와 같지 않아야함
      let query = pageData?.query
    else {
      return
    }

    let books = try await bookRepo.searchPage(query: query, page: nextPage)
    pageData = PageData( // 페이지 데이터 업데이트
      query: query,
      curPage: Int(books.page),
      totalPage: Int(books.total)
    )

    Task { @MainActor in
      self.books += books.books // 책 추가
      presenter?.updateListView()
    }
  }

}
