//
//  CommentEntity.swift
//  Data
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Domain
import Foundation

struct CommentEntity: Codable {
    let postID: Int
    let ID: Int
    let name: String
    let email: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case ID = "id"
        case name
        case email
        case description = "body"
    }
    
    func toDomain() throws -> Comment {
        return Comment(postID: postID,
                       ID: ID,
                       name: name,
                       email: email,
                       description: description)
    }
}
