//
//  AddressEntity.swift
//  Data
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Domain
import Foundation

struct AddressEntity: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geoLocation: CoordinateEntity
    
    enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geoLocation = "geo"
    }
    
    func toDomain() throws -> Address {
        return Address(street: street,
                       suite: suite,
                       city: city,
                       zipcode: zipcode,
                       geoLocation: try geoLocation.toDomain())
    }
}

struct CoordinateEntity: Codable {
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
    
    func toDomain() throws -> Coordinates {
        return Coordinates(latitude: latitude,
                           longitude: longitude)
    }
}
