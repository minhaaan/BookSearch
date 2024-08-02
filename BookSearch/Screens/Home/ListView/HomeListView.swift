//
//  HomeListView.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

protocol HomeListPresentableListener: AnyObject {
  var books: [SearchDTO.Book] { get }
  var imageLoader: ImageLoader { get }

  func updateQuery(query: String) async
  func didSelectItemAt(indexPath: IndexPath) async
  func willDisplay(query: String, indexPath: IndexPath) async
}

final class HomeListView: UIView, HomeListPresentable {

  // MARK: Properties

  var listener: HomeListPresentableListener?

  // MARK: Layout Props

  private let searchBar = UISearchBar()

  let listView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()
  )

  // MARK: init

  init() {
    super.init(frame: .zero)
    setupLayout()
    setupCollectionViewLayout()

    searchBar.delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Method

  func updateListView() {
    listView.reloadData()
  }

  private func setupCollectionViewLayout() {
    // 아이템 사이즈 정의
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(100)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    // 그룹 사이즈 정리
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: itemSize,
      subitems: [item]
    )

    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 2

    let layout = UICollectionViewCompositionalLayout(section: section)

    self.listView.collectionViewLayout = layout

    // 셀 등록
    self.listView.register(HomeListViewCell.self, forCellWithReuseIdentifier: HomeListViewCell.ID)

    // dataSource, delegate 설정
    self.listView.dataSource = self
    self.listView.delegate = self
  }

  private func setupLayout() {
    addSubview(searchBar)
    addSubview(listView)

    // SearchBar 레이아웃 설정
    addSubview(searchBar)
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])

    listView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      listView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      listView.leadingAnchor.constraint(equalTo: leadingAnchor),
      listView.trailingAnchor.constraint(equalTo: trailingAnchor),
      listView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

// MARK: UICollectionViewDataSource

extension HomeListView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return listener?.books.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: HomeListViewCell.ID,
      for: indexPath
    ) as? HomeListViewCell,
          let book = listener?.books[indexPath.row]
    else {
      return UICollectionViewCell()
    }
    cell.updateCellData(
      book: book,
      imageLoader: listener?.imageLoader ?? ImageLoader()
    )
    return cell
  }
}

// MARK: UICollectionViewDelegate

extension HomeListView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    Task {
      guard let query = searchBar.text else { return }
      await listener?.willDisplay(query: query, indexPath: indexPath)
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    Task {
      await listener?.didSelectItemAt(indexPath: indexPath)
    }
  }
}

// MARK: UISearchBarDelegate

extension HomeListView: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    Task {
      await listener?.updateQuery(query: searchText)
    }
  }
}


