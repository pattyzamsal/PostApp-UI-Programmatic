//
//  CommentsProvider.swift
//  Data
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Domain
import Foundation

public class CommentsProvider {
    private let apiClient: APIClient
    
    public init() {
        apiClient = APIClient()
    }
}

extension CommentsProvider: CommentsProviderContract {
    public func getComments(postID: String, completion: @escaping (Result<[Comment], Error>) -> Void) {
        apiClient.execute(endpoint: .getCommentsInPost(postID: postID)) { (response: WebServiceResponse<[CommentEntity]>) in
            guard case .success(modelData: let entities) = response,
                  let data = entities else {
                if case .failure(let error) = response,
                   let webError = error as? WebServiceProtocolError,
                   let message = webError.errorDescription {
                    completion(.failure(CommentsProviderContractError.generic(error: message)))
                }
                return
            }
            do {
                let models = try data.map { try $0.toDomain() }
                completion(.success(models))
            } catch {
                let errorString = WebServiceProtocolError.serializationError.errorDescription ?? "Error"
                completion(.failure(CommentsProviderContractError.generic(error: errorString)))
            }
        }
    }
}
