//
//  User.swift
//  Domain
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation

public struct User {
    public let ID: Int
    public let name: String
    public let username: String
    public let email: String
    public let phone: String
    public let website: String
    public let address: Address
    public let company: Company
    
    public init(ID: Int,
                name: String,
                username: String,
                email: String,
                phone: String,
                website: String,
                address: Address,
                company: Company) {
        self.ID = ID
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
        self.address = address
        self.company = company
    }
}
