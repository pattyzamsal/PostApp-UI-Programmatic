//
//  CompanyEntity.swift
//  Data
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Domain
import Foundation

struct CompanyEntity: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    func toDomain() throws -> Company {
        return Company(name: name,
                       catchPhrase: catchPhrase,
                       bs: bs)
    }
}
