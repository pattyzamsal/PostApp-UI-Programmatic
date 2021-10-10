//
//  UserUseCase.swift
//  Domain
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation

public protocol UserUseCaseContract {
    func getUserByID(_ ID: String, completion: @escaping(Result<User, Error>) -> Void)
}

public enum UserUseCaseError: Error {
    case generic(error: String)
    
    public var errorDescription: String? {
        switch self {
        case .generic(let error):
            return error
        }
    }
}

public final class UserUseCase {
    let provider: UserProviderContract
    
    public init(provider: UserProviderContract) {
        self.provider = provider
    }
}

extension UserUseCase: UserUseCaseContract {
    public func getUserByID(_ ID: String, completion: @escaping (Result<User, Error>) -> Void) {
        return provider.getUserByID(ID) { (result) in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                if let providerError = error as? UserProviderContractError,
                   let message = providerError.errorDescription {
                    completion(.failure(UserUseCaseError.generic(error: message)))
                }
            }
        }
    }
}
