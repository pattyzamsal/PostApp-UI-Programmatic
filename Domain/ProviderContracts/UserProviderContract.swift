//
//  UserProviderContract.swift
//  Domain
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation

public enum UserProviderContractError: Error {
    case generic(error: String)
    
    public var errorDescription: String? {
        switch self {
        case .generic(let error):
            return error
        }
    }
}

public protocol UserProviderContract {
    func getUserByID(_ ID: String, completion: @escaping (Result<User, Error>) -> Void)
}
