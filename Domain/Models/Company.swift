//
//  Company.swift
//  Domain
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation

public struct Company {
    public let name: String
    public let catchPhrase: String
    public let bs: String
    
    public init(name: String,
                catchPhrase: String,
                bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}
