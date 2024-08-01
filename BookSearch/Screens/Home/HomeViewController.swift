import UIKit

final class HomeViewController: UIViewController {

  // MARK: Properties

  // MARK: Layout Props

  private let searchBar = UISearchBar()

  private let listView = UICollectionView(
    frame: .zero,
    collectionViewLayout: .init()
  )

  // MARK: LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupLayout()
  }

  // MARK: Method

  // MARK: Private Method

  // MARK: Layout Method

  private func setupLayout() {
    view.backgroundColor = .systemBackground

    // SearchBar 레이아웃 설정
    view.addSubview(searchBar)
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])

    // ListView 레이아웃 설정
    view.addSubview(listView)
    listView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      listView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  private func setupCollectionView() {
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

    self.listView.collectionViewLayout = layout
    
    // 셀 등록
    self.listView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell") // TODO: Cell 등록 수정

    // dataSource, delegate 설정
    self.listView.dataSource = self
    self.listView.delegate = self
  }

}

// MARK: UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 200
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) // TODO: Cell 수정
    cell.backgroundColor = .systemBlue
    return cell
  }
}

// MARK: UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {

}
