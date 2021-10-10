//
//  CommentsUseCaseTests.swift
//  DomainTests
//
//  Created by Patricia Zambrano on 10/10/21.
//

@testable import Domain
import XCTest

final class CommentsUseCaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetCommentsUseCaseWithSuccess() {
        let expectation = XCTestExpectation(description: "Fetch comments")
        let commentsTest = getComments()
        let useCase = MockCommentsUseCase(comments: commentsTest)
        useCase.getComments(postID: "1") { (result) in
            switch result {
            case .success(let comments):
                XCTAssertEqual(comments.count, commentsTest.count)
                expectation.fulfill()
            case .failure:
                XCTFail("Unexpected error")
            }
        }
    }
    
    func testGetCommentsUseCaseWithError() {
        let expectation = XCTestExpectation(description: "Fetch comments with error")
        let useCase = MockCommentsUseCase(comments: nil)
        useCase.getComments(postID: "") { (result) in
            switch result {
            case .success:
                XCTFail("Unexpected error")
            case .failure(let error):
                if let error = error as? MockCommentsUseCaseError {
                    XCTAssertEqual(error, .generic)
                    expectation.fulfill()
                } else {
                    XCTFail("Unexpected error")
                }
            }
        }
    }
}

private extension CommentsUseCaseTests {
    func getComments() -> [Comment] {
        let firstComment = Comment(postID: 1,
                              ID: 1,
                              name: "id labore ex et quam laborum",
                              email: "Eliseo@gardner.biz",
                              description: "laudantium enim quasi est quidem magnam voluptate ipsam eos tempora quo necessitatibus dolor quam autem quasi reiciendis et nam sapiente accusantium")
        let secondComment = Comment(postID: 1,
                                    ID: 2,
                                    name: "quo vero reiciendis velit similique earum",
                                    email: "Jayne_Kuhic@sydney.com",
                                    description: "est natus enim nihil est dolore omnis voluptatem numquam et omnis occaecati quod ullam at voluptatem error expedita pariatur nihil sint nostrum voluptatem reiciendis et")
        return [firstComment, secondComment]
    }
}
