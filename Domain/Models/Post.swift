//
//  Post.swift
//  Domain
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation

public struct Post {
    public let userID: Int
    public let ID: Int
    public let title: String
    public let description: String
    public var isRead: Bool
    public var isFavorite: Bool
    
    public init(userID: Int,
                ID: Int,
                title: String,
                description: String,
                isRead: Bool,
                isFavorite: Bool) {
        self.userID = userID
        self.ID = ID
        self.title = title
        self.description = description
        self.isRead = isRead
        self.isFavorite = isFavorite
    }
}
