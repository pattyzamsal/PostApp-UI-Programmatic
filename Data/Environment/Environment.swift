//
//  Environment.swift
//  Data
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation

import Foundation

struct Environment {
    static let baseURL: String = Bundle.main.infoDictionary?["Base url"] as! String
}
