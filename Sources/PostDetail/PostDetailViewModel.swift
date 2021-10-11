//
//  PostDetailViewModel.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Foundation

struct PostDetailViewModel: Equatable {
    var ID: Int
    var title: String
    var description: String
    var isFavorite: Bool
    var useViewModel: UserViewModel
    var commentsViewModel: [CommentViewModel]
}

struct UserViewModel: Equatable {
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    var address: String
    var error: String
}

struct CommentViewModel: Equatable {
    var commentTitle: String
    var commentDescription: String
    var commentByPerson: String
}
