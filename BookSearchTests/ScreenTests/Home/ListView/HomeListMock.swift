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

  // MARK: - willDisplay

  var willDisplayQueryIndexPathCallsCount = 0
  var willDisplayQueryIndexPathCalled: Bool {
    willDisplayQueryIndexPathCallsCount > 0
  }
  var willDisplayQueryIndexPathReceivedArguments: (query: String, indexPath: IndexPath)?
  var willDisplayQueryIndexPathReceivedInvocations: [(query: String, indexPath: IndexPath)] = []
  var willDisplayQueryIndexPathClosure: ((String, IndexPath) -> Void)?

  func willDisplay(query: String, indexPath: IndexPath) async {
    willDisplayQueryIndexPathCallsCount += 1
    willDisplayQueryIndexPathReceivedArguments = (query: query, indexPath: indexPath)
    willDisplayQueryIndexPathReceivedInvocations.append((query: query, indexPath: indexPath))
    willDisplayQueryIndexPathClosure?(query, indexPath)
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

