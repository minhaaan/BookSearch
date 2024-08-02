//
//  HomeListMock.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/2/24.
//

@testable import BookSearch
import Foundation


// MARK: - HomeListPresentableListenerMock -

final class HomeListPresentableListenerMock: HomeListPresentableListener {
  var books: [SearchDTO.Book] = []
  var imageLoader: ImageLoader = .init()

  // MARK: - updateQuery

  var updateQueryQueryCallsCount = 0
  var updateQueryQueryCalled: Bool {
    updateQueryQueryCallsCount > 0
  }
  var updateQueryQueryReceivedQuery: String?
  var updateQueryQueryReceivedInvocations: [String] = []
  var updateQueryQueryClosure: ((String) -> Void)?

  func updateQuery(query: String) async {
    updateQueryQueryCallsCount += 1
    updateQueryQueryReceivedQuery = query
    updateQueryQueryReceivedInvocations.append(query)
    updateQueryQueryClosure?(query)
  }
}

// MARK: - HomeListPresentableMock -

final class HomeListPresentableMock: HomeListPresentable {

  // MARK: - updateListView

  var updateListViewCallsCount = 0
  var updateListViewCalled: Bool {
    updateListViewCallsCount > 0
  }
  var updateListViewClosure: (() -> Void)?

  func updateListView() {
    updateListViewCallsCount += 1
    updateListViewClosure?()
  }
}

