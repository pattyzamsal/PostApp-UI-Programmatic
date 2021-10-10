//
//  PostsListPresenter.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Domain
import Foundation

final class PostsListPresenter {
    private weak var view: PostsListContract.View?
    private let navigator: PostsListContract.Navigator
    private let postsUseCase: PostsUseCaseContract
    
    private var viewState: PostsListViewState = .clear {
        didSet {
            guard oldValue != viewState else {
                return
            }
            view?.render(state: viewState)
        }
    }
    
    private var postsList: [Post] = []
    private var isFavoriteSelected = false
    
    init(view: PostsListContract.View?,
         navigator: PostsListContract.Navigator,
         postsUseCase: PostsUseCaseContract) {
        self.view = view
        self.navigator = navigator
        self.postsUseCase = postsUseCase
    }
}

extension PostsListPresenter: PostsListContract.Presenter {
    func getPostsList() {
        viewState = .loading
        postsUseCase.getPosts { response in
            switch response {
            case .success(let posts):
                self.setValues(posts: posts)
            case .failure(let error):
                var message = error.localizedDescription
                if let errorUseCase = error as? PostsUseCaseError,
                   let errorDescription = errorUseCase.errorDescription {
                    message = errorDescription
                }
                self.viewState = .error(error: message)
            }
        }
    }
    
    func didTapRefresh() {
        postsList.removeAll()
        viewState = .loading
        postsUseCase.getPosts { response in
            switch response {
            case .success(let posts):
                self.setValues(posts: posts)
            case .failure(let error):
                var message = error.localizedDescription
                if let errorUseCase = error as? PostsUseCaseError,
                   let errorDescription = errorUseCase.errorDescription {
                    message = errorDescription
                }
                self.viewState = .error(error: message)
            }
        }
    }
    
    func getIsFavoriteSelected() -> Bool {
        return isFavoriteSelected
    }
    
    func didTapAllPosts() {
        isFavoriteSelected = false
        viewState = .render(posts: getPostsListViewModel(posts: postsList))
    }
    
    func didTapFavoritesPosts() {
        isFavoriteSelected = true
        let favoritesPosts = postsList.filter { $0.isFavorite }
        viewState = .render(posts: getPostsListViewModel(posts: favoritesPosts))
    }
    
    func didTapDelete() {
        postsList.removeAll()
        viewState = .render(posts: getPostsListViewModel(posts: postsList))
    }
    
    func didTapPost(ID: Int) {
        updateListWithID(ID)
        navigator.presentPostDetail()
    }
    
    func goToPreviousView() {
        navigator.presentPreviousView()
    }
}

private extension PostsListPresenter {
    func setValues(posts: [Post]) {
        var copyPosts = posts
        for (index, _) in posts.enumerated() {
            if index > 20 {
                copyPosts[index].isRead = true
            }
        }
        postsList = copyPosts
        viewState = .render(posts: self.getPostsListViewModel(posts: postsList))
    }
    
    func getPostsListViewModel(posts: [Post]) -> [PostViewModel] {
        return posts.map {
            PostViewModel(ID: $0.ID,
                               title: $0.title,
                               isRead: $0.isRead,
                               isFavorite: $0.isFavorite)
        }
    }
    
    func updateListWithID(_ ID: Int) {
        var indexInt = 0
        guard let index = postsList.firstIndex(where: {$0.ID == ID}) else {
            return
        }
        indexInt = postsList.distance(from: postsList.startIndex, to: index)
        postsList[indexInt].isRead = true
    }

    func getPostBy(ID: Int) -> Post? {
        return postsList.filter{ $0.ID == ID }.first
    }
}
