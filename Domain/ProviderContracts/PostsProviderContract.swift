//
//  PostsProviderContract.swift
//  Domain
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation

public enum PostsProviderContractError: Error {
    case generic(error: String)
    
    public var errorDescription: String? {
        switch self {
        case .generic(let error):
            return error
        }
    }
}

public protocol PostsProviderContract {
    func getPost(completion: @escaping (Result<[Post], Error>) -> Void)
}
