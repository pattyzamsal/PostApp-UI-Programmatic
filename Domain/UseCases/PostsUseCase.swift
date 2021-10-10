//
//  PostsUseCase.swift
//  Domain
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation

public protocol PostsUseCaseContract {
    func getPosts(completion: @escaping(Result<[Post], Error>) -> Void)
}

public enum PostsUseCaseError: Error {
    case generic(error: String)
    
    public var errorDescription: String? {
        switch self {
        case .generic(let error):
            return error
        }
    }
}

public final class PostsUseCase {
    let provider: PostsProviderContract
    
    public init(provider: PostsProviderContract) {
        self.provider = provider
    }
}

extension PostsUseCase: PostsUseCaseContract {
    public func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        return provider.getPost { (result) in
            switch result {
            case .success(let posts):
                completion(.success(posts))
            case .failure(let error):
                if let providerError = error as? PostsProviderContractError,
                   let message = providerError.errorDescription {
                    completion(.failure(PostsUseCaseError.generic(error: message)))
                }
            }
        }
    }
}
