//
//  MockUserProvider.swift
//  DataTests
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation
@testable import Data
@testable import Domain

enum MockUserProviderContractError: Error {
    case generic
}

final class MockUserProvider {
    private let mockAPIClient: MockAPIClient
    
    init(result: Result<Data, Error>) {
        mockAPIClient = MockAPIClient(result: result)
    }
    
    func getUserByID(_ ID: String, completion: @escaping (Result<User, Error>) -> Void) {
        mockAPIClient.execute(endpoint: .getUser(userID: ID)) { (response: WebServiceResponse<UserEntity>) in
            guard case .success(modelData: let entity) = response,
                  let model = try? entity?.toDomain() else {
                completion(.failure(MockUserProviderContractError.generic))
                return
            }
            completion(.success(model))
        }
    }
}
