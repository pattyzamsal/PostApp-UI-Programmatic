//
//  UserEntity.swift
//  Data
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Domain
import Foundation

struct UserEntity: Codable {
    let ID: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: AddressEntity
    let company: CompanyEntity
    
    enum CodingKeys: String, CodingKey {
        case ID = "id"
        case name
        case username
        case email
        case phone
        case website
        case address
        case company
    }
    
    func toDomain() throws -> User {
        return User(ID: ID,
                    name: name,
                    username: username,
                    email: email,
                    phone: phone,
                    website: website,
                    address: try address.toDomain(),
                    company: try company.toDomain())
    }
}
