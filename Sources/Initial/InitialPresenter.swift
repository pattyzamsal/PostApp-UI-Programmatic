//
//  InitialPresenter.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Foundation

final class InitialPresenter {
    private weak var view: InitialContract.View?
    private let navigator: InitialContract.Navigator
    
    private var viewState: InitialViewState = .clear {
        didSet {
            guard oldValue != viewState else {
                return
            }
            view?.renderViewState(viewState)
        }
    }
    
    init(view: InitialContract.View?,
         navigator: InitialContract.Navigator) {
        self.view = view
        self.navigator = navigator
    }
}

extension InitialPresenter: InitialContract.Presenter {
    func didTapStartButton() {
        navigator.presentListPosts()
    }
}
