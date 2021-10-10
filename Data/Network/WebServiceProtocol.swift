//
//  WebServiceProtocol.swift
//  Data
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation

public enum WebServiceResponse<T: Decodable> {
    case success(modelData: T?)
    case failure(error: Error?)
}

public enum WebServiceProtocolError: Error {
    case parsingError(error: String)
    case serializationError
    case notFound
    case server
    case noConnection
}

extension WebServiceProtocolError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parsingError(let error):
            return "Cannot parse response: \(error)"
        case .serializationError:
            return "Cannot serialize model"
        case .notFound:
            return "Cannot find the request"
        case .server:
            return "Error server"
        case .noConnection:
            return "Perhaps, you have problems with your connection"
        }
    }
}

public typealias WebServiceHandler<T:Decodable> = ((_ response: WebServiceResponse<T>) -> Void)

public protocol WebServiceProtocol {
    func execute<Output: Decodable>(endpoint: APIRouter,
                                    completion: @escaping WebServiceHandler<Output>)
}
