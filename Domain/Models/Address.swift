//
//  Address.swift
//  Domain
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation

public struct Address {
    public let street: String
    public let suite: String
    public let city: String
    public let zipcode: String
    public let geoLocation: Coordinates
    
    public init(street: String,
                suite: String,
                city: String,
                zipcode: String,
                geoLocation: Coordinates) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geoLocation = geoLocation
    }
}

public struct Coordinates {
    public let latitude: String
    public let longitude: String
    
    public init(latitude: String,
                longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
