//
//  MockUserUseCase.swift
//  DomainTests
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Foundation

@testable import Domain
import XCTest

enum MockUserUseCaseError: Error {
    case generic
}

final class MockUserUseCase: UserUseCaseContract {
    var user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    func getUserByID(_ ID: String, completion: @escaping (Result<User, Error>) -> Void) {
        if let user = user {
            completion(.success(user))
        } else {
            completion(.failure(MockUserUseCaseError.generic))
        }
    }
}
