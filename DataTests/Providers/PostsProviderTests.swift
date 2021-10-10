//
//  PostsProviderTests.swift
//  DataTests
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation
import XCTest
@testable import Data

final class PostsProviderTests: XCTestCase {
    private var provider: MockPostsProvider!
    private var data: Data!
    private var postsEntity: [PostEntity]!
    private lazy var mockDataTests = DataTestsMock()
    
    override func setUp() {
        super.setUp()
        guard let url = mockDataTests.getLocalURLPathOfMockJSONBy(nameFile: "Posts"),
              let data = mockDataTests.convertURLToData(url: url),
              let posts = try? JSONDecoder().decode([PostEntity].self, from: data) else {
            return
        }
        self.data = data
        self.postsEntity = posts
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPostParseSuccess() {
        let expectation = XCTestExpectation(description: "Parse posts")
        guard let url = mockDataTests.getLocalURLPathOfMockJSONBy(nameFile: "Posts") else {
            XCTFail("Couldn't get json file")
            return
        }
        guard let data = mockDataTests.convertURLToData(url: url) else {
            XCTFail("Couldn't load data")
            return
        }
        do {
            let result = try JSONDecoder().decode([PostEntity].self, from: data)
            XCTAssertNotNil(result)
            expectation.fulfill()
        } catch {
            XCTFail("Couldn't get object from data")
        }
    }
    
    func testGetPostsWithSuccess() {
        let expectation = XCTestExpectation(description: "Fetch posts")
        provider = MockPostsProvider(result: .success(data))
        provider.getPosts() { (result) in
            switch result {
            case .success(let posts):
                do {
                    let postsModel = try self.postsEntity.map { try $0.toDomain() }
                    XCTAssertEqual(posts.count, postsModel.count)
                    expectation.fulfill()
                } catch {
                    XCTFail("Unexpected error")
                }
            case .failure:
                XCTFail("Unexpected error")
            }
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testGetPostsWithError() {
        let expectation = XCTestExpectation(description: "Fetch posts with error")
        let errorData = Data()
        provider = MockPostsProvider(result: .success(errorData))
        provider.getPosts() { (result) in
            switch result {
            case .success:
                XCTFail("Unexpected error")
            case .failure(let error):
                if let error = error as? MockPostsProviderContractError {
                    XCTAssertEqual(error, .generic)
                    expectation.fulfill()
                } else {
                    XCTFail("Unexpected error")
                }
            }
        }
        wait(for: [expectation], timeout: 3)
    }
}
