//
//  CommentsProviderTests.swift
//  DataTests
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation
import XCTest
@testable import Data

final class CommentsProviderTests: XCTestCase {
    private var provider: MockCommentsProvider!
    private var data: Data!
    private var commentsEntity: [CommentEntity]!
    private lazy var mockDataTests = DataTestsMock()
    
    override func setUp() {
        super.setUp()
        guard let url = mockDataTests.getLocalURLPathOfMockJSONBy(nameFile: "Comments"),
              let data = mockDataTests.convertURLToData(url: url),
              let comments = try? JSONDecoder().decode([CommentEntity].self, from: data) else {
            return
        }
        self.data = data
        self.commentsEntity = comments
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCommentsParseSuccess() {
        let expectation = XCTestExpectation(description: "Parse comments")
        guard let url = mockDataTests.getLocalURLPathOfMockJSONBy(nameFile: "Comments") else {
            XCTFail("Couldn't get json file")
            return
        }
        guard let data = mockDataTests.convertURLToData(url: url) else {
            XCTFail("Couldn't load data")
            return
        }
        do {
            let result = try JSONDecoder().decode([CommentEntity].self, from: data)
            XCTAssertNotNil(result)
            expectation.fulfill()
        } catch {
            XCTFail("Couldn't get object from data")
        }
    }
    
    func testGetCommentsWithSuccess() {
        let expectation = XCTestExpectation(description: "Fetch comments")
        provider = MockCommentsProvider(result: .success(data))
        provider.getComments(postID: "1") { (result) in
            switch result {
            case .success(let comments):
                do {
                    let commentsModel = try self.commentsEntity.map { try $0.toDomain() }
                    XCTAssertEqual(comments.count, commentsModel.count)
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
    
    func testGetCommentsWithError() {
        let expectation = XCTestExpectation(description: "Fetch comments with error")
        let errorData = Data()
        provider = MockCommentsProvider(result: .success(errorData))
        provider.getComments(postID: "") { (result) in
            switch result {
            case .success:
                XCTFail("Unexpected error")
            case .failure(let error):
                if let error = error as? MockCommentsProviderContractError {
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
