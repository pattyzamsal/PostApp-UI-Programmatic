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
    
    private let titleLabel: UILabel = {
        let titleLabel = PostLabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.assignBoldLargeStyle()
        return titleLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = PostLabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.assignRegularJustifiedStyle()
        return descriptionLabel
    }()
    
    private let userTitleLabel: UILabel = {
        let userTitleLabel = PostLabel()
        userTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        userTitleLabel.assignBoldStyle()
        return userTitleLabel
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = PostLabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.assignRegularStyle()
        return nameLabel
    }()
    
    private let usernameLabel: UILabel = {
        let usernameLabel = PostLabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.assignRegularStyle()
        return usernameLabel
    }()
    
    private let phoneLabel: UILabel = {
        let phoneLabel = PostLabel()
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.assignRegularStyle()
        return phoneLabel
    }()
    
    private let emailLabel: UILabel = {
        let emailLabel = PostLabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.assignRegularStyle()
        return emailLabel
    }()
    
    private let websiteLabel: UILabel = {
        let websiteLabel = PostLabel()
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        websiteLabel.assignRegularStyle()
        return websiteLabel
    }()
    
    private let addressLabel: UILabel = {
        let addressLabel = PostLabel()
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.assignRegularStyle()
        return addressLabel
    }()
    
    private var userStackView: UIStackView!
    
    private let commentsLabel: UILabel = {
        let commentsLabel = PostLabel()
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsLabel.assignBoldStyle()
        return commentsLabel
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.getColorApp(name: .blueLight)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let commentsEmptyView: EmptyView = {
        let commentsEmptyView = EmptyView()
        commentsEmptyView.backgroundColor = .white
        commentsEmptyView.translatesAutoresizingMaskIntoConstraints = false
        return commentsEmptyView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = UIColor.getColorApp(name: .blueLight)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
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
    
    override func loadView() {
        super.loadView()
        createViews()
    }

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
    func createViews() {
        view.backgroundColor = .white
        createUserStackView()
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(userStackView)
        view.addSubview(commentsLabel)
        view.addSubview(commentsEmptyView)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        addConstraintsForViews()
    }
    
    func createUserStackView() {
        let views = [userTitleLabel, nameLabel, usernameLabel,
                     phoneLabel, emailLabel, websiteLabel, addressLabel]
        userTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        phoneLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        websiteLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        userStackView = stackView
    }
    
    func addConstraintsForViews() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            userStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            userStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            commentsLabel.topAnchor.constraint(equalTo: userStackView.bottomAnchor, constant: 10),
            commentsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            commentsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            commentsEmptyView.topAnchor.constraint(equalTo: commentsLabel.bottomAnchor, constant: 5),
            commentsEmptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            commentsEmptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: commentsLabel.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
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
