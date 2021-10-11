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
//    func getCharacterDetailViewModel(character: CharacterMarvel) -> CharacterDetailViewModel {
//        let description = character.description.isEmpty ? TextsConstants.basicDescription.rawValue : character.description
//        return CharacterDetailViewModel(name: character.name,
//                                        description: description,
//                                        photoURL: character.thumbnailURL)
//    }
}

extension PostDetailPresenter: PostDetailContract.Presenter {
    func setPostDetail(post: PostViewModel?) {
        self.post = post
    }
    
    func didTapFavorite() {
        guard let actualPost = post else {
            return
        }
        post?.isFavorite = !actualPost.isFavorite
        viewState = .paintStar(isFavorite: !actualPost.isFavorite)
    }
    
//    func getCharacter(id: String) {
//        viewState = .loading
//        self.id = id
//        characterDetailUseCase.getCharacterDetailBy(id: id) { (response) in
//            switch response {
//            case .success(let character):
//                let characterViewModel = self.getCharacterDetailViewModel(character: character)
//                self.view?.render(state: .render(character: characterViewModel))
//            case .failure(let error):
//                var message = error.localizedDescription
//                if let errorUseCase = error as? CharacterDetailUseCaseError,
//                   let errorDescription = errorUseCase.errorDescription {
//                    message = errorDescription
//                }
//                self.view?.render(state: .error(error: message))
//            }
//        }
//    }
    
    func goToPreviousView() {
        guard let actualPost = post else {
            return
        }
        navigator.presentPreviousView(post: actualPost)
    }
}
