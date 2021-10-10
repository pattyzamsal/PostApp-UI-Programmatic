//
//  CommentsUseCase.swift
//  Domain
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation

public protocol CommentsUseCaseContract {
    func getComments(postID: String, completion: @escaping(Result<[Comment], Error>) -> Void)
}

public enum CommentsUseCaseError: Error {
    case generic(error: String)
    
    public var errorDescription: String? {
        switch self {
        case .generic(let error):
            return error
        }
    }
}

public final class CommentsUseCase {
    let provider: CommentsProviderContract
    
    public init(provider: CommentsProviderContract) {
        self.provider = provider
    }
}

extension CommentsUseCase: CommentsUseCaseContract {
    public func getComments(postID: String, completion: @escaping (Result<[Comment], Error>) -> Void) {
        return provider.getComments(postID: postID) { (result) in
            switch result {
            case .success(let comments):
                completion(.success(comments))
            case .failure(let error):
                if let providerError = error as? CommentsProviderContractError,
                   let message = providerError.errorDescription {
                    completion(.failure(CommentsUseCaseError.generic(error: message)))
                }
            }
        }
    }
}
