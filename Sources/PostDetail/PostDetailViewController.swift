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
    
    private lazy var presenter: PostDetailContract.Presenter = {
        let navigator = PostDetailNavigator(viewController: self)
        let userUseCase = PostsInjector.provideUserUseCase()
        let commentsUseCase = PostsInjector.provideCommentsUseCase()
        return PostDetailPresenter(view: self,
                                   navigator: navigator,
                                   userUseCase: userUseCase,
                                   commentsUseCase: commentsUseCase)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
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
