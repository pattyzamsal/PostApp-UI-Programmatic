//
//  InitialContract.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Foundation

enum InitialContract {
    typealias Presenter = InitialPresenterContract
    typealias View = InitialViewContract
    typealias Navigator = InitialNavigatorContract
}

protocol InitialPresenterContract {
    func didTapStartButton()
}

protocol InitialViewContract: AnyObject {
    func renderViewState(_ state: InitialViewState)
}

protocol InitialNavigatorContract {
    func presentListPosts()
}

enum InitialViewState {
    case clear
}
