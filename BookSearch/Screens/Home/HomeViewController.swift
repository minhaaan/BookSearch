import UIKit

protocol HomePresentableListener: AnyObject {
}

final class HomeViewController: UIViewController, HomePresentable {

  // MARK: Properties

  var listener: HomePresentableListener?

  // MARK: Layout Props

  private let searchBar = UISearchBar()

  private let listView: UIView

  // MARK: init

  init(listView: UIView) {
    self.listView = listView
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

  // MARK: Method

  // MARK: Private Method

  // MARK: Layout Method

  private func setupLayout() {
    view.backgroundColor = .systemBackground

    // ListView 레이아웃 설정
    view.addSubview(listView)
    listView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      listView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

}
