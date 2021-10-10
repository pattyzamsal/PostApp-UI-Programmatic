//
//  MockCommentsUseCase.swift
//  DomainTests
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Foundation

@testable import Domain
import XCTest

enum MockCommentsUseCaseError: Error {
    case generic
}

final class MockCommentsUseCase: CommentsUseCaseContract {
    var comments: [Comment]?
    
    init(comments: [Comment]?) {
        self.comments = comments
    }
    
    func getComments(postID: String, completion: @escaping (Result<[Comment], Error>) -> Void) {
        if let comments = comments {
            completion(.success(comments))
        } else {
            completion(.failure(MockCommentsUseCaseError.generic))
        }
    }
}
