//
//  DetailInteractor.swift
//  BookSearch
//
//  Created by 최민한 on 8/3/24.
//

import UIKit
import PDFKit

extension Detail {
  protocol Presentable: AnyObject {
    /// 책 상세데이터로 Label 추가
    func updateLabelData(data: DetailDTO) async
    /// 썸네일 이미지 업데이트
    /// - Parameter image: UIImage
    func updateImage(image: UIImage) async
    /// PDF View 추가, PDF 데이터 있고 비어있지 않을때만 실행됨
    /// - Parameter pdfDocument: PDFDocument Data
    func addPdfView(pdfDocument: PDFDocument) async
    /// 데이터 조회 실패했을때 Alert 띄우는 함수
    func showFetchErrorAlert() async
  }
}

extension Detail {
  final class Interactor: Detail.PresentableListener {

    // MARK: Properties

    private let isbn: String
    private let bookRepo: BookRepository
    private let imageLoader: ImageLoadable

    weak var presenter: Presentable?

    // MARK: init

    init(
      isbn: String,
      bookRepo: BookRepository,
      imageLoader: ImageLoadable
    ) {
      self.isbn = isbn
      self.bookRepo = bookRepo
      self.imageLoader = imageLoader
    }

    // MARK: Method

    func fetchDetailData() async {
      // 데이터 조회
      guard let detail = try? await bookRepo.detail(isbn: isbn) else {
        await presenter?.showFetchErrorAlert() // 데이터 조회 실패하면 Error Alert 띄운다
        return
      }
      await presenter?.updateLabelData(data: detail) // 라벨 데이터 업데이트

      // 이미지 조회 + 이미지 업데이트
      if let imageURL = URL(string: detail.image) {
        async let image = imageLoader.loadImage(from: imageURL)
        try? await presenter?.updateImage(image: image)
      }

      // PDF 생성
      if let pdf = detail.pdf, pdf.count > 0 {
        async let pdfDocument = createPdfDocument(pdfData: pdf)
        if let pdfDocument = await pdfDocument {
          await presenter?.addPdfView(pdfDocument: pdfDocument)
        }
      }

    }

    /// PDF Document 생성
    private func createPdfDocument(pdfData: [String: String]) async -> PDFDocument? {
      let urls = pdfData.values.compactMap { URL(string: "\($0)") } // 생성할 pdf url

      guard urls.count > 0 else { return nil } // 비어있다면 nil Return

      let document = PDFDocument()
      // Page 추가
      urls.compactMap { PDFDocument(url: $0) }.forEach { _document in
        for i in 0..<_document.pageCount {
          if let page: PDFPage = _document.page(at: i) {
            document.insert(page, at: document.pageCount)
          }
        }
      }
      return document
    }

  }
}
