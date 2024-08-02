//
//  DetailInteractorTests.swift
//  BookSearchTests
//
//  Created by 최민한 on 8/3/24.
//

@testable import BookSearch
import XCTest

final class DetailInteractorTests: XCTestCase {

  var interactor: DetailInteractor!
  let isbn = "213213213213"
  var bookRepo: BookRepositoryMock!
  var presenter: DetailPresentableMock!
  var imageLoader: ImageLoaderMock!

  override func setUpWithError() throws {
    bookRepo = BookRepositoryMock()
    presenter = DetailPresentableMock()
    imageLoader = ImageLoaderMock()
    interactor = DetailInteractor(
      isbn: isbn,
      bookRepo: bookRepo,
      imageLoader: imageLoader
    )
    interactor.presenter = presenter
  }

  override func tearDownWithError() throws {
  }

  func test_fetchDetailData_성공() async {
    // GIVEN

    // WHEN
    await interactor.fetchDetailData()

    // THEN
    XCTAssert(bookRepo.detailIsbnCallsCount == 1) // API 호출했는지 확인
    XCTAssert(presenter.updateLabelDataDataCallsCount == 1) // Label 업데이트 확인
    XCTAssert(presenter.updateImageImageCallsCount == 1) // 이미지 업데이트 확인
    XCTAssert(presenter.addPdfViewPdfDocumentCallsCount == 1) // PDF 확인
    XCTAssert(imageLoader.loadImageCallsCount == 1) // 이미지 요청했는지 확인
  }

  func test_fetchDetailData_실패() async {
    // GIVEN
    // 실패환경세팅
    bookRepo.detailError = URLError(.badServerResponse)

    // WHEN
    await interactor.fetchDetailData()

    // THEN
    XCTAssert(bookRepo.detailIsbnCallsCount == 1) // API 호출확인
    XCTAssert(presenter.showFetchErrorAlertCallsCount == 1) // 에러 표시 호출확인
  }

}
