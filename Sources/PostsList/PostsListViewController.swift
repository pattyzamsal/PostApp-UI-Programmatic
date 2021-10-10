//
//  PostsListViewController.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Injector
import UIKit

class PostsListViewController: BaseViewController {
    @IBOutlet private weak var emptyView: EmptyView!
    @IBOutlet private weak var postsView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var favoriteEmptyView: EmptyView!
    @IBOutlet private weak var deleteButton: UIButton!
    
    private lazy var presenter: PostsListContract.Presenter = {
        let navigator = PostsListNavigator(viewController: self)
        let postsUseCase = PostsInjector.providePostsUseCase()
        return PostsListPresenter(view: self,
                                  navigator: navigator,
                                  postsUseCase: postsUseCase)
    }()
    
    private var postsList = [PostViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.getPostsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackButton(title: "")
        setRightBarButton()
        title = TextsConstants.postsList.rawValue
    }
    
    @IBAction func didTapSegmentedControl(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            presenter.didTapAllPosts()
        } else {
            presenter.didTapFavoritesPosts()
        }
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any) {
        presenter.didTapDelete()
    }
}

private extension PostsListViewController {
    func showPostsView(isEmpty: Bool) {
        emptyView.isHidden = !isEmpty
        postsView.isHidden = isEmpty
    }
    
    func showTableView(isEmpty: Bool) {
        favoriteEmptyView.isHidden = !isEmpty
        tableView.isHidden = isEmpty
    }
    
    func setupViews() {
        setActivityIndicator(activityIndicator)
        emptyView.fill(description: TextsConstants.noPosts.rawValue)
        setupSegmentedControl()
        deleteButton.setTitle(TextsConstants.deleteAllPosts.rawValue, for: .normal)
        favoriteEmptyView.fill(description: TextsConstants.noFavorites.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80.0
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        PostTableViewCell.registerCellForTable(tableView)
    }
    
    func setRightBarButton() {
        let item = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
        setRightButtonWithItem(item)
    }
    
    func setupSegmentedControl() {
        let colorSelected = UIColor.getColorApp(name: .blueLight) ?? .black
        segmentedControl.setTitle(TextsConstants.allTitle.rawValue, forSegmentAt: 0)
        segmentedControl.setTitle(TextsConstants.favoritesTitle.rawValue, forSegmentAt: 1)
        segmentedControl.backgroundColor = .white
        segmentedControl.layer.borderColor = colorSelected.cgColor
        segmentedControl.selectedSegmentTintColor = UIColor.getColorApp(name: .blueLight)
        segmentedControl.layer.borderWidth = 1
        let titleAttributes = [NSAttributedString.Key.foregroundColor: colorSelected]
        segmentedControl.setTitleTextAttributes(titleAttributes, for: .normal)
        let titleAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(titleAttributes1, for: .selected)
    }
    
    @objc func didTapRefresh() {
        presenter.didTapRefresh()
    }
    
    func updateViews(posts: [PostViewModel]) {
        postsList = posts
        deleteButton.isHidden = presenter.getIsFavoriteSelected()
        if !presenter.getIsFavoriteSelected() {
            showPostsView(isEmpty: postsList.isEmpty)
        }
        showTableView(isEmpty: postsList.isEmpty)
        tableView.reloadData()
    }
}

extension PostsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        let post = postsList[indexPath.row]
        cell.fill(post: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapPost(ID: postsList[indexPath.row].ID)
    }
}

extension PostsListViewController: PostsListContract.View {
    func render(state: PostsListViewState) {
        switch state {
        case .clear:
            break
        case .loading:
            showLoading()
        case .render(let posts):
            hideLoading()
            updateViews(posts: posts)
        case .error(let error):
            hideLoading()
            showAlertView(error: error) { (_) in
                self.presenter.goToPreviousView()
            }
        }
    }
}
