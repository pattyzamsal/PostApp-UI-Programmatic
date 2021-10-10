//
//  APIRouter.swift
//  Data
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation
import Alamofire

private enum Paths: String {
    case listPosts = "/posts"
    case commentsInPost = "/posts/@/comments"
    case user = "/users/@"
}

public enum APIRouter: URLRequestConvertible {
    case getListPosts
    case getCommentsInPost(postID: String)
    case getUser(userID: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        return .get
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getListPosts:
            return Paths.listPosts.rawValue
        case .getCommentsInPost(let postID):
            return Paths.commentsInPost.rawValue.replacingOccurrences(of: "@", with: postID)
        case .getUser(let userID):
            return Paths.user.rawValue.replacingOccurrences(of: "@", with: userID)
        }
    }
    
    // MARK: - URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        let url = try Environment.baseURL.asURL()
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
