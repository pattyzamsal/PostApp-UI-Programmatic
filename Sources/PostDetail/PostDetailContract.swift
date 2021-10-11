//
//  PostDetailContract.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Foundation

enum PostDetailContract {
    typealias Presenter = PostDetailPresenterContract
    typealias View = PostDetailViewContract
    typealias Navigator = PostDetailNavigatorContract
}

protocol PostDetailPresenterContract {
    func setPostDetail(post: PostViewModel?)
    func didTapFavorite()
    func goToPreviousView()
}

protocol PostDetailViewContract: AnyObject {
    func render(state: PostDetailViewState)
}

protocol PostDetailNavigatorContract {
    func presentPreviousView(post: PostViewModel)
}

enum PostDetailViewState: Equatable {
    case clear
    case loading
    case render(post: PostDetailViewModel)
    case paintStar(isFavorite: Bool)
    case error(error: String)
}
