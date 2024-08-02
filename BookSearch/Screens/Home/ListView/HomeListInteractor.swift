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

  // MARK: Properties

  weak var presenter: HomeListPresentable?

  private let bookRepo: BookRepository

  private let debouncer: Debouncer

  var books: [SearchDTO.Book] = []

  // MARK: init

  init(
    bookRepo: BookRepository,
    debouncer: Debouncer = DebouncerImpl()
  ) {
    self.bookRepo = bookRepo
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
      self.presenter?.updateListView()

      // query가 비어있다면 API 요청하지않음
      guard query.isEmpty == false else { return }

      // API 요청
      do {
        let books = try await self.bookRepo.search(query: query)
        self.books = books.books
        presenter?.updateListView()
      } catch {
      }
    }
  }

}



