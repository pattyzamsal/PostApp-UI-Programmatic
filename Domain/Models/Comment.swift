//
//  Comment.swift
//  Domain
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation

public struct Comment {
    public let postID: Int
    public let ID: Int
    public let name: String
    public let email: String
    public let description: String
    
    public init(postID: Int,
                ID: Int,
                name: String,
                email: String,
                description: String) {
        self.postID = postID
        self.ID = ID
        self.name = name
        self.email = email
        self.description = description
    }
}
