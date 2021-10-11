//
//  TextsConstants.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Foundation

enum TextsConstants: String {
    // MARK: - Alert
    case occurAnError = "Occurs an error"
    case accept = "OK"
    
    // MARK: - Initial View
    case initialTitle = "Posts App"
    case descriptionApp = "This app shows a list of posts and you can access the detail of each of them"
    case startButtonTitle = "Start"
    
    // MARK: - Posts List
    case postsList = "List of posts"
    case allTitle = "All"
    case favoritesTitle = "Favorites"
    case deleteAllPosts = "Delete all posts"
    case noPosts = "There aren't any post to show"
    case noFavorites = "There aren't any favorite post"
    
    // MARK: - Post Detail
    case postDetail = "Post's detail"
    case userInformation = "User information"
    case userInformationError = "It wasn't be possible to get user's information"
    case userName = "Name: @"
    case userUsername = "Username: @"
    case userEmail = "Email: @"
    case userPhone = "Phone: @"
    case userWebsite = "Website: @"
    case userAddress = "Address: @"
    case commentsTitle = "Comments"
    case commentByEmail = "Comment by: @"
    case noComments = "There aren't any registered comment about this post"
}
