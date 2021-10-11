//
//  PostDetailPresenter.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Domain
import Foundation

final class PostDetailPresenter {
    private weak var view: PostDetailContract.View?
    private let navigator: PostDetailContract.Navigator
    private let userUseCase: UserUseCaseContract
    private let commentsUseCase: CommentsUseCaseContract
    
    private var viewState: PostDetailViewState = .clear {
        didSet {
            guard oldValue != viewState else {
                return
            }
            view?.render(state: viewState)
        }
    }
    
    private var post: PostViewModel?
    private var user: User?
    private var comments: [Comment] = []
    private var errorWithUserMessage: String = ""
    
    init(view: PostDetailContract.View?,
         navigator: PostDetailContract.Navigator,
         userUseCase: UserUseCaseContract,
         commentsUseCase: CommentsUseCaseContract) {
        self.view = view
        self.navigator = navigator
        self.userUseCase = userUseCase
        self.commentsUseCase = commentsUseCase
    }
}

private extension PostDetailPresenter {
    func getUserByID() {
        let userID = post?.userID ?? ""
        userUseCase.getUserByID(userID) { response in
            switch response {
            case .success(let user):
                self.user = user
            case .failure(let error):
                var message = error.localizedDescription
                if let errorUseCase = error as? UserUseCaseError,
                   let errorDescription = errorUseCase.errorDescription {
                    message = errorDescription
                    self.errorWithUserMessage = message
                }
            }
            self.getComments()
        }
    }
    
    func getComments() {
        let postID = post?.ID ?? 0
        let postIDText = postID == 0 ? "" : String(postID)
        commentsUseCase.getComments(postID: postIDText) { response in
            switch response {
            case .success(let comments):
                self.comments = comments
            case .failure(let error):
                var message = error.localizedDescription
                if let errorUseCase = error as? CommentsUseCaseError,
                   let errorDescription = errorUseCase.errorDescription {
                    message = errorDescription
                    print("\(message)")
                }
            }
            self.sendToView()
        }
    }
    
    func sendToView() {
        guard let viewModel = getPostDetailViewModel() else {
            viewState = .error(error: TextsConstants.occurAnError.rawValue)
            return
        }
        viewState = .render(post: viewModel)
    }
    
    func getPostDetailViewModel() -> PostDetailViewModel? {
        guard let postViewModel = post,
                let userModel = user else {
            return nil
        }
        return PostDetailViewModel(ID: postViewModel.ID,
                                   title: postViewModel.title,
                                   description: postViewModel.description,
                                   isFavorite: postViewModel.isFavorite,
                                   useViewModel: getUserViewModel(userModel: userModel),
                                   commentsViewModel: getCommentsViewModel())
    }
    
    func getUserViewModel(userModel: User) -> UserViewModel {
        let name = TextsConstants.userName.rawValue.replacingOccurrences(of: "@", with: userModel.name)
        let username = TextsConstants.userUsername.rawValue.replacingOccurrences(of: "@", with: userModel.username)
        let phone = TextsConstants.userPhone.rawValue.replacingOccurrences(of: "@", with: userModel.phone)
        let email = TextsConstants.userEmail.rawValue.replacingOccurrences(of: "@", with: userModel.email)
        let website = TextsConstants.userWebsite.rawValue.replacingOccurrences(of: "@", with: userModel.website)
        let addressText = "\(userModel.address.street). \(userModel.address.suite). \(userModel.address.city)"
        let address = TextsConstants.userAddress.rawValue.replacingOccurrences(of: "@", with: addressText)
        
        return UserViewModel(name: name,
                             username: username,
                             email: email,
                             phone: phone,
                             website: website,
                             address: address,
                             error: errorWithUserMessage)
    }
    
    func getCommentsViewModel() -> [CommentViewModel] {
        var commentsViewModel: [CommentViewModel] = []
        commentsViewModel = comments.map { comment in
            let author = TextsConstants.commentByEmail.rawValue.replacingOccurrences(of: "@", with: comment.email)
            return CommentViewModel(commentTitle: comment.name,
                                    commentDescription: comment.description,
                                    commentByPerson: author)
        }
        return commentsViewModel
    }
}

extension PostDetailPresenter: PostDetailContract.Presenter {
    func setPostDetail(post: PostViewModel?) {
        self.post = post
        viewState = .loading
        getUserByID()
    }
    
    func didTapFavorite() {
        guard let actualPost = post else {
            return
        }
        post?.isFavorite = !actualPost.isFavorite
        viewState = .paintStar(isFavorite: !actualPost.isFavorite)
    }
    
    func goToPreviousView() {
        guard let actualPost = post else {
            return
        }
        navigator.presentPreviousView(post: actualPost)
    }
}
