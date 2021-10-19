//
//  PostsListViewController.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Injector
import UIKit

class PostsListViewController: BaseViewController {
    private let emptyView: EmptyView = {
        let emptyView = EmptyView()
        emptyView.backgroundColor = .white
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
    }()
    
    private let postsView: UIView = {
        let postsView = UIView()
        postsView.backgroundColor = .white
        postsView.translatesAutoresizingMaskIntoConstraints = false
        return postsView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.tintColor = UIColor.getColorApp(name: .blueLight)
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["First", "Second"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.getColorApp(name: .blueLight)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.allowsSelection = true
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let favoriteEmptyView: EmptyView = {
        let favoriteEmptyView = EmptyView()
        favoriteEmptyView.backgroundColor = .white
        favoriteEmptyView.translatesAutoresizingMaskIntoConstraints = false
        return favoriteEmptyView
    }()
    
    private let deleteButton: UIButton = {
        let deleteButton = UIButton(type: .custom)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.backgroundColor = .red
        deleteButton.titleLabel?.textColor = .white
        deleteButton.titleLabel?.font = UIFont.getFontApp(style: .bold, size: .large)
        return deleteButton
    }()
    
    private lazy var presenter: PostsListContract.Presenter = {
        let navigator = PostsListNavigator(viewController: self)
        let postsUseCase = PostsInjector.providePostsUseCase()
        return PostsListPresenter(view: self,
                                  navigator: navigator,
                                  postsUseCase: postsUseCase)
    }()
    
    private var postsList = [PostViewModel]()
    
    override func loadView() {
        super.loadView()
        createViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.getPostsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackButton(action: #selector(didTapBackButton))
        setRightBarButton()
        title = TextsConstants.postsList.rawValue
    }
    
    @objc func didTapSegmentedControl(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            presenter.didTapAllPosts()
        } else {
            presenter.didTapFavoritesPosts()
        }
    }
    
    @objc func didTapDeleteButton(_ sender: Any) {
        presenter.didTapDelete()
    }
    
    func reloadView(post: PostViewModel) {
        presenter.reloadView(post: post)
    }
}

private extension PostsListViewController {
    func createViews() {
        view.backgroundColor = .white
        postsView.addSubview(segmentedControl)
        postsView.addSubview(favoriteEmptyView)
        postsView.addSubview(tableView)
        postsView.addSubview(deleteButton)
        addConstraintsForPostViews()
        view.addSubview(emptyView)
        view.addSubview(postsView)
        view.addSubview(activityIndicator)
        addConstraintsForViews()
    }
    
    func addConstraintsForPostViews() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: postsView.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: postsView.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: postsView.trailingAnchor, constant: -20),
            
            favoriteEmptyView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 2),
            favoriteEmptyView.leadingAnchor.constraint(equalTo: postsView.leadingAnchor),
            favoriteEmptyView.trailingAnchor.constraint(equalTo: postsView.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 2),
            tableView.leadingAnchor.constraint(equalTo: postsView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: postsView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: 0),
            
            deleteButton.topAnchor.constraint(equalTo: favoriteEmptyView.bottomAnchor, constant: 0),
            deleteButton.leadingAnchor.constraint(equalTo: postsView.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: postsView.trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: postsView.bottomAnchor, constant: -20)
        ])
    }
    
    func addConstraintsForViews() {
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            postsView.topAnchor.constraint(equalTo: view.topAnchor),
            postsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            postsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
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
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
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
        segmentedControl.addTarget(self, action: #selector(didTapSegmentedControl), for: .valueChanged)
    }
    
    @objc func didTapBackButton() {
        presenter.goToPreviousView()
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
    
    func swipeToDeletePost(ID: Int) {
        presenter.swipeToDeletePost(ID: ID)
    }
    
    func setDeleteAction(ID: Int) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .destructive, title: TextsConstants.delete.rawValue) { [weak self] (action, view, completion) in
            self?.swipeToDeletePost(ID: ID)
        }
        deleteAction.backgroundColor = UIColor.red
        return deleteAction
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
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let postID = postsList[indexPath.row].ID
        let configuration = UISwipeActionsConfiguration(actions: [setDeleteAction(ID: postID)])
        return configuration
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
