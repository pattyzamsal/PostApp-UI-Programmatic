//
//  PostsProvider.swift
//  Data
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Domain
import Foundation

public class PostsProvider {
    private let apiClient: APIClient
    
    public init() {
        apiClient = APIClient()
    }
}

extension PostsProvider: PostsProviderContract {
    public func getPost(completion: @escaping (Result<[Post], Error>) -> Void) {
        apiClient.execute(endpoint: .getListPosts) { (response: WebServiceResponse<[PostEntity]>) in
            guard case .success(modelData: let entities) = response,
                  let data = entities else {
                if case .failure(let error) = response,
                   let webError = error as? WebServiceProtocolError,
                   let message = webError.errorDescription {
                    completion(.failure(PostsProviderContractError.generic(error: message)))
                }
                return
            }
            do {
                let models = try data.map { try $0.toDomain() }
                completion(.success(models))
            } catch {
                let errorString = WebServiceProtocolError.serializationError.errorDescription ?? "Error"
                completion(.failure(PostsProviderContractError.generic(error: errorString)))
            }
        }
    }
}
