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

  var willDisplayIndexPathCallsCount = 0
  var willDisplayIndexPathCalled: Bool {
    willDisplayIndexPathCallsCount > 0
  }
  var willDisplayIndexPathReceivedIndexPath: IndexPath?
  var willDisplayIndexPathReceivedInvocations: [IndexPath] = []
  var willDisplayIndexPathClosure: ((IndexPath) -> Void)?

  func willDisplay(indexPath: IndexPath) {
    willDisplayIndexPathCallsCount += 1
    willDisplayIndexPathReceivedIndexPath = indexPath
    willDisplayIndexPathReceivedInvocations.append(indexPath)
    willDisplayIndexPathClosure?(indexPath)
  }

  // MARK: - didSelectItemAt
  var didSelectItemAtCallsCount = 0
  func didSelectItemAt(indexPath: IndexPath) async {
    didSelectItemAtCallsCount += 1
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

// MARK: - HomeListListenerMock -

final class HomeListListenerMock: HomeListListener {

  // MARK: - routeDetail

  var routeDetailIsbn13CallsCount = 0
  var routeDetailIsbn13Called: Bool {
    routeDetailIsbn13CallsCount > 0
  }
  var routeDetailIsbn13ReceivedIsbn13: String?
  var routeDetailIsbn13ReceivedInvocations: [String] = []
  var routeDetailIsbn13Closure: ((String) -> Void)?

  func routeDetail(isbn13: String) async {
    routeDetailIsbn13CallsCount += 1
    routeDetailIsbn13ReceivedIsbn13 = isbn13
    routeDetailIsbn13ReceivedInvocations.append(isbn13)
    routeDetailIsbn13Closure?(isbn13)
  }
}
