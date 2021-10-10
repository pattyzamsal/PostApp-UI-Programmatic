//
//  PostEntity.swift
//  Data
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Domain
import Foundation

struct PostEntity: Codable {
    let userID: Int
    let ID: Int
    let title: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case ID = "id"
        case title
        case description = "body"
    }
    
    func toDomain() throws -> Post {
        return Post(userID: userID,
                    ID: ID,
                    title: title,
                    description: description,
                    isRead: false,
                    isFavorite: false)
    }
}
