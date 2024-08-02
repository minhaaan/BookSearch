import UIKit

final class HomeViewController: UIViewController {

  // MARK: Properties

  // MARK: Layout Props

  private let searchBar = UISearchBar()

  private let listView = HomeListView()

  // MARK: LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
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

}

