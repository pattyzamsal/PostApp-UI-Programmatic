//
//  MockPostsUseCase.swift
//  DomainTests
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Foundation

@testable import Domain
import XCTest

enum MockPostsUseCaseError: Error {
    case generic
}

final class MockPostsUseCase: PostsUseCaseContract {
    var posts: [Post]?
    
    init(posts: [Post]?) {
        self.posts = posts
    }
    
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        if let posts = posts {
            completion(.success(posts))
        } else {
            completion(.failure(MockPostsUseCaseError.generic))
        }
    }
}
