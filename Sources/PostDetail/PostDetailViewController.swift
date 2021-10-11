//
//  PostDetailViewController.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Injector
import UIKit

class PostDetailViewController: BaseViewController {
    var post: PostViewModel?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var userStackView: UIStackView!
    @IBOutlet private weak var userTitleLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var commentsLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var commentsEmptyView: EmptyView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private lazy var presenter: PostDetailContract.Presenter = {
        let navigator = PostDetailNavigator(viewController: self)
        let userUseCase = PostsInjector.provideUserUseCase()
        let commentsUseCase = PostsInjector.provideCommentsUseCase()
        return PostDetailPresenter(view: self,
                                   navigator: navigator,
                                   userUseCase: userUseCase,
                                   commentsUseCase: commentsUseCase)
    }()
    
    private var commentsList = [CommentViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.setPostDetail(post: post)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackButton(action: #selector(didTapBack))
        setRightBarButton(isFavorite: post?.isFavorite ?? false)
        title = TextsConstants.postDetail.rawValue
    }
}

private extension PostDetailViewController {
    func setupViews() {
        setActivityIndicator(activityIndicator)
        setupUserView()
        setupCommentsViews()
    }
    
    func setupUserView() {
        userTitleLabel.text = TextsConstants.userInformation.rawValue
    }
    
    func setupCommentsViews() {
        commentsLabel.text = TextsConstants.commentsTitle.rawValue
        commentsEmptyView.fill(description: TextsConstants.noComments.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80.0
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        CommentTableViewCell.registerCellForTable(tableView)
    }
    
    func showUserViews(isHidden: Bool) {
        usernameLabel.isHidden = isHidden
        phoneLabel.isHidden = isHidden
        emailLabel.isHidden = isHidden
        websiteLabel.isHidden = isHidden
        addressLabel.isHidden = isHidden
    }
    
    func showTableView(isEmpty: Bool) {
        commentsEmptyView.isHidden = !isEmpty
        tableView.isHidden = isEmpty
    }
    
    @objc func didTapBack() {
        presenter.goToPreviousView()
    }
    
    func setRightBarButton(isFavorite: Bool) {
        let image = isFavorite == true ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didTapFavorite))
        setRightButtonWithItem(item)
    }
    
    @objc func didTapFavorite() {
        presenter.didTapFavorite()
    }
    
    func updateView(post: PostDetailViewModel) {
        titleLabel.text = post.title
        descriptionLabel.text = post.description
        updateUserView(user: post.useViewModel)
        updateCommentsViews(comments: post.commentsViewModel)
    }
    
    func updateUserView(user: UserViewModel) {
        if !user.error.isEmpty {
            nameLabel.text = TextsConstants.userInformationError.rawValue
            showUserViews(isHidden: true)
        } else {
            showUserViews(isHidden: false)
            nameLabel.text = user.name
            usernameLabel.text = user.username
            phoneLabel.text = user.phone
            emailLabel.text = user.email
            websiteLabel.text = user.website
            addressLabel.text = user.address
        }
    }
    
    func updateCommentsViews(comments: [CommentViewModel]) {
        commentsList = comments
        showTableView(isEmpty: commentsList.isEmpty)
        tableView.reloadData()
    }
}

extension PostDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else {
            return UITableViewCell()
        }
        let comment = commentsList[indexPath.row]
        cell.fill(comment: comment)
        return cell
    }
}

extension PostDetailViewController: PostDetailContract.View {
    func render(state: PostDetailViewState) {
        switch state {
        case .clear:
            break
        case .loading:
            showLoading()
        case .render(let post):
            hideLoading()
            updateView(post: post)
        case .paintStar(let isFavorite):
            setRightBarButton(isFavorite: isFavorite)
        case .error(let error):
            hideLoading()
            showAlertView(error: error) { (_) in
                self.presenter.goToPreviousView()
            }
        }
    }
}
