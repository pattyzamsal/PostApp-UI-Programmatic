//
//  UserProvider.swift
//  Data
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Domain
import Foundation

public class UserProvider {
    private let apiClient: APIClient
    
    public init() {
        apiClient = APIClient()
    }
}

extension UserProvider: UserProviderContract {
    public func getUserByID(_ ID: String, completion: @escaping (Result<User, Error>) -> Void) {
        apiClient.execute(endpoint: .getUser(userID: ID)) { (response: WebServiceResponse<UserEntity>) in
            guard case .success(modelData: let entity) = response,
                  let model = try? entity?.toDomain() else {
                      if case .failure(let error) = response,
                         let webError = error as? WebServiceProtocolError,
                         let message = webError.errorDescription {
                          completion(.failure(UserProviderContractError.generic(error: message)))
                      }
                      return
            }
            completion(.success(model))
        }
    }
}
