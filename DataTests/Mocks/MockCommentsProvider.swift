//
//  MockCommentsProvider.swift
//  DataTests
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation
@testable import Data
@testable import Domain

enum MockCommentsProviderContractError: Error {
    case generic
}

class MockCommentsProvider {
    private let mockAPIClient: MockAPIClient
    
    init(result: Result<Data, Error>) {
        mockAPIClient = MockAPIClient(result: result)
    }
    
    func getComments(postID: String, completion: @escaping (Result<[Comment], Error>) -> Void) {
        mockAPIClient.execute(endpoint: .getCommentsInPost(postID: postID)) {  (response: WebServiceResponse<[CommentEntity]>) in
            guard case .success(modelData: let entities) = response,
                  let data = entities else {
                      completion(.failure(MockCommentsProviderContractError.generic))
                      return
            }
            do {
                let models = try data.map { try $0.toDomain() }
                completion(.success(models))
            } catch {
                completion(.failure(MockCommentsProviderContractError.generic))
            }
        }
    }
}
