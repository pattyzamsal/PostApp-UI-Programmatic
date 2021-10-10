//
//  PostsListContract.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Foundation

enum PostsListContract {
    typealias Presenter = PostsListPresenterContract
    typealias View = PostsListViewContract
    typealias Navigator = PostsListNavigatorContract
}

protocol PostsListPresenterContract {
    func getPostsList()
    func didTapRefresh()
    func getIsFavoriteSelected() -> Bool
    func didTapAllPosts()
    func didTapFavoritesPosts()
    func didTapDelete()
    func didTapPost(ID: Int)
    func goToPreviousView()
}

protocol PostsListViewContract: AnyObject {
    func render(state: PostsListViewState)
}

protocol PostsListNavigatorContract {
    func presentPostDetail()
    func presentPreviousView()
}

enum PostsListViewState: Equatable {
    case clear
    case loading
    case render(posts: [PostViewModel])
    case error(error: String)
}
