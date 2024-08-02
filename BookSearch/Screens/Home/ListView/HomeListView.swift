//
//  HomeListView.swift
//  BookSearch
//
//  Created by 최민한 on 8/2/24.
//

import UIKit

final class HomeListView: UICollectionView {

  // MARK: Properties

  // MARK: init

  init() {
    super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    setupCollectionViewLayout()
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  // MARK: Method

  private func setupCollectionViewLayout() {
    // 아이템 사이즈 정의
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(40)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    // 그룹 사이즈 정리
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    )
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: groupSize,
      subitems: [item]
    )
    group.interItemSpacing = .fixed(10) // 아이템 간격 조정

    let section = NSCollectionLayoutSection(group: group)
    let layout = UICollectionViewCompositionalLayout(section: section)

    self.collectionViewLayout = layout

    // 셀 등록
    self.register(HomeListViewCell.self, forCellWithReuseIdentifier: HomeListViewCell.ID)

    // dataSource, delegate 설정
    self.dataSource = self
    self.delegate = self
  }

}

// MARK: UICollectionViewDataSource

extension HomeListView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 200
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: HomeListViewCell.ID,
      for: indexPath
    ) as? HomeListViewCell else {
      return UICollectionViewCell()
    }
    cell.titleLabel.text = "asdsad"
    return cell
  }
}

// MARK: UICollectionViewDelegate

extension HomeListView: UICollectionViewDelegate {

}
