//
//  MockAPIClient.swift
//  DataTests
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation
@testable import Data

final class MockAPIClient: WebServiceProtocol {
    let result: Result<Data, Error>
    
    init(result: Result<Data, Error>) {
        self.result = result
    }
    
    func execute<Output>(endpoint: APIRouter, completion: @escaping WebServiceHandler<Output>) where Output : Decodable {
        switch result {
        case .success(let data):
            do {
                let model = try JSONDecoder().decode(Output.self, from: data)
                completion(.success(modelData: model))
            } catch {
                completion(.failure(error: error))
            }
        case .failure(let error):
            completion(.failure(error: error))
        }
    }
}
