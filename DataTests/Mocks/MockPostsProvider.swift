//
//  MockPostsProvider.swift
//  DataTests
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation
@testable import Data
@testable import Domain

enum MockPostsProviderContractError: Error {
    case generic
}

final class MockPostsProvider {
    private let mockAPIClient: MockAPIClient
    
    init(result: Result<Data, Error>) {
        mockAPIClient = MockAPIClient(result: result)
    }
    
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        mockAPIClient.execute(endpoint: .getListPosts) { (response: WebServiceResponse<[PostEntity]>) in
            guard case .success(modelData: let entities) = response,
                  let data = entities else {
                      completion(.failure(MockPostsProviderContractError.generic))
                      return
            }
            do {
                let models = try data.map { try $0.toDomain() }
                completion(.success(models))
            } catch {
                completion(.failure(MockPostsProviderContractError.generic))
            }
        }
    }
}
