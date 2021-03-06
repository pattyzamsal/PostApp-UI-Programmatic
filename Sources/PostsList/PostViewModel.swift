//
//  PostsListViewModel.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Foundation

struct PostViewModel: Equatable {
    var ID: Int
    var userID: String
    var title: String
    var description: String
    var isRead: Bool
    var isFavorite: Bool
}
