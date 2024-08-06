//
//  DetailMock.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/3/24.
//

@testable import BookSearch
import UIKit
import PDFKit

// MARK: - DetailPresentableMock -

final class DetailPresentableMock: Detail.Presentable {

  // MARK: - updateLabelData

  var updateLabelDataDataCallsCount = 0
  var updateLabelDataDataCalled: Bool {
    updateLabelDataDataCallsCount > 0
  }
  func updateLabelData(data: DetailDTO) async {
    updateLabelDataDataCallsCount += 1
  }

  // MARK: - updateImage

  var updateImageImageCallsCount = 0
  var updateImageImageCalled: Bool {
    updateImageImageCallsCount > 0
  }
  func updateImage(image: UIImage) async {
    updateImageImageCallsCount += 1
  }

  // MARK: - addPdfView

  var addPdfViewPdfDocumentCallsCount = 0
  var addPdfViewPdfDocumentCalled: Bool {
    addPdfViewPdfDocumentCallsCount > 0
  }
  func addPdfView(pdfDocument: PDFDocument) {
    addPdfViewPdfDocumentCallsCount += 1
  }

  // MARK: - showFetchErrorAlert

  var showFetchErrorAlertCallsCount = 0
  var showFetchErrorAlertCalled: Bool {
    showFetchErrorAlertCallsCount > 0
  }
  func showFetchErrorAlert() async {
    showFetchErrorAlertCallsCount += 1
  }
}

// MARK: DetailRouterMock

final class DetailRouterMock: Detail.Routable {
  var showErrorAlertCallsCount = 0
  func showErrorAlert() async {
    showErrorAlertCallsCount += 1
  }
}

// MARK: DetailPresentableListenerMock

final class DetailPresentableListenerMock: Detail.PresentableListener {
  var fetchDetailDataCallsCount = 0
  func fetchDetailData() async {
    fetchDetailDataCallsCount += 1
  }
}
