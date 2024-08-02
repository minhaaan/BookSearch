//
//  DetailViewController.swift
//  BookSearch
//
//  Created by 최민한 on 8/3/24.
//

import UIKit
import PDFKit

protocol DetailRoutable {
  func showErrorAlert() async
}

protocol DetailPresentableListener: AnyObject {
  func fetchDetailData() async
}

final class DetailViewController: UIViewController, DetailPresentable {

  // MARK: Properties

  var listener: DetailPresentableListener?
  var router: DetailRoutable?

  private var hasFetchedDetailData: Bool = false

  // MARK: Layout Props

  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    return scrollView
  }()

  private let stackView: UIStackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.spacing = 10
    sv.distribution = .fillProportionally
    return sv
  }()
  
  private let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    return iv
  }()

  private let pdfView: PDFView = {
    let pdfView = PDFView()
    pdfView.autoScales = true
    return pdfView
  }()

  // MARK: init

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    guard hasFetchedDetailData == false else { return } // 이미 조회했다면 안함
    Task {
      hasFetchedDetailData = true
      await listener?.fetchDetailData()
    }
  }

  // MARK: Method

  func updateImage(image: UIImage) async {
    imageView.image = image
  }

  func addPdfView(pdfDocument document: PDFDocument) async {
    let pdfView = PDFView()
    pdfView.autoScales = true
    pdfView.document = document
    stackView.addArrangedSubview(pdfView)
    NSLayoutConstraint.activate([
      pdfView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
      pdfView.heightAnchor.constraint(equalToConstant: scrollView.frame.height)
    ])
  }

  func updateLabelData(data: DetailDTO) async {
    data.allLabelTextProperties()
      .map(createLabel)
      .forEach { label in
        self.stackView.addArrangedSubview(label)
      }
  }

  func showFetchErrorAlert() async {
    await router?.showErrorAlert()
  }

  /// Label 생성
  /// - Parameters:
  ///   - name: 데이터 종류
  ///   - value: 데이터 값
  /// - Returns: UILabel
  private func createLabel(
    _ name: String,
    _ value: String
  ) -> UILabel {
    let label = UILabel()
    label.text = name + ": " + value
    label.font = .systemFont(ofSize: 15)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }

  // MARK: Layout Method

  private func setupLayout() {
    view.backgroundColor = .tertiarySystemBackground

    // ScrollView Layout
    view.addSubview(scrollView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    // StackView Layout
    scrollView.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])

    // StackView에 imageView, pdfView 추가
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(pdfView)
  }


}

private extension DetailDTO {
  /// DetailDTO에서 iamge, pdf 빼고 name, value tuple 로 리턴
  func allLabelTextProperties() -> [(String, String)] {
    Mirror(reflecting: self).children
      .filter { ["pdf", "image"].contains($0.label) == false }
      .compactMap { (label, value) -> (String, String)? in
        guard let label, let value = value as? String else { return nil }
        return (label, value)
      }
  }
}
