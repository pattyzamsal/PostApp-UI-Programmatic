//
//  APIClient.swift
//  Data
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation
import Alamofire

final class APIClient: WebServiceProtocol {
    func execute<Output>(endpoint: APIRouter, completion: @escaping WebServiceHandler<Output>) {
        if !isConnectedToInternet() {
            completion(.failure(error: WebServiceProtocolError.noConnection))
            return
        }
        let request = endpoint as URLRequestConvertible
        AF.request(request)
            .logRequest()
            .validate { (_, httpResponse, _) -> DataRequest.ValidationResult in
                if self.isOccuringAnError(response: httpResponse) {
                    return .failure(self.getError(response: httpResponse))
                } else {
                    return .success(())
                }
            }
            .responseJSON{ response in
                guard let data = response.data else {
                    completion(.failure(error: WebServiceProtocolError.server))
                    return
                }
                switch response.result {
                case .success:
                    do {
                        let result = try JSONDecoder().decode(Output.self, from: data)
                        completion(.success(modelData: result))
                    } catch {
                        completion(.failure(error: WebServiceProtocolError.serializationError))
                    }
                case .failure:
                    completion(.failure(error: WebServiceProtocolError.serializationError))
                }
            }
    }
}

private extension APIClient {
    func isConnectedToInternet() -> Bool {
        if let network = NetworkReachabilityManager() {
            return network.isReachable
        }
        return false
    }
    
    func isOccuringAnError(response: HTTPURLResponse) -> Bool {
        return  [401, 403, 405, 409].contains(response.statusCode) || (500..<600 ~= response.statusCode)
    }
    
    func getError(response: HTTPURLResponse) -> WebServiceProtocolError {
        if (500..<600 ~= response.statusCode) {
            return .server
        } else {
            return .parsingError(error: response.description)
        }
    }
}

private extension DataRequest {
    func logRequest() -> Self {
        responseData { response in
            print(response.debugDescription)
        }
        return self
    }
}
