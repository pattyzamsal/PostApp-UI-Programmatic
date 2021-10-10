//
//  CommentsProviderContract.swift
//  Domain
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation

public enum CommentsProviderContractError: Error {
    case generic(error: String)
    
    public var errorDescription: String? {
        switch self {
        case .generic(let error):
            return error
        }
    }
}

public protocol CommentsProviderContract {
    func getComments(postID: String, completion: @escaping (Result<[Comment], Error>) -> Void)
}
