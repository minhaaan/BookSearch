//
//  HomeListViewCell.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

final class HomeListViewCell: UICollectionViewCell {

  // MARK: Properties

  static let ID = String(describing: HomeListViewCell.self)

  private var imageDownloadTask: Task<Void, Never>?

  // MARK: Layout Props

  private let titleLabel = DefaultLabel()
  private let subtitleLabel = DefaultLabel()
  private let isbnLabel = DefaultLabel()
  private let priceLabel = DefaultLabel()
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  private let urlLabel = DefaultLabel()

  // MARK: init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: LifeCycle

  override func prepareForReuse() {
    super.prepareForReuse()
    // Label Text, ImageView image 초기화
    [titleLabel, subtitleLabel, isbnLabel, priceLabel, urlLabel].forEach {
      $0.text = nil
    }
    imageView.image = nil
    imageDownloadTask?.cancel() // 이미지 다운로드 태스크 취소
  }

  // MARK: Method
  
  /// 셀 데이터 업데이트
  func updateCellData(book: SearchDTO.Book, imageLoader: ImageLoader) {
    titleLabel.text = book.title
    subtitleLabel.text = book.subtitle
    isbnLabel.text = book.isbn13
    priceLabel.text = book.price
    
    imageDownloadTask?.cancel() // 기존 이미지 다운로드 태스크 취소
    if let imageURL = URL(string: book.image) {
      imageDownloadTask = Task { [weak self] in
        let image = try? await imageLoader.loadImage(from: imageURL)
        guard Task.isCancelled == false else { return } // 취소된 작업이라면 변경하지 않음
        self?.imageView.image = image
      }
    }

    urlLabel.text = book.url
  }

  private func setupLayout() {
    contentView.backgroundColor = .secondarySystemBackground

    let stackView = UIStackView(arrangedSubviews: [
      imageView, titleLabel, subtitleLabel, isbnLabel, priceLabel, urlLabel
    ])
    stackView.spacing = 2
    stackView.axis = .vertical

    contentView.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

      imageView.widthAnchor.constraint(equalToConstant: 100),
      imageView.heightAnchor.constraint(equalToConstant: 100)
    ])
  }

}
