//
//  PostsUseCaseTests.swift
//  DomainTests
//
//  Created by Patricia Zambrano on 10/10/21.
//

@testable import Domain
import XCTest

final class PostsUseCaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetPostsUseCaseWithSuccess() {
        let expectation = XCTestExpectation(description: "Fetch posts")
        let postsTest = getPosts()
        let useCase = MockPostsUseCase(posts: postsTest)
        useCase.getPosts() { (result) in
            switch result {
            case .success(let posts):
                XCTAssertEqual(posts.count, postsTest.count)
                expectation.fulfill()
            case .failure:
                XCTFail("Unexpected error")
            }
        }
    }
    
    func testGetPostsUseCaseWithError() {
        let expectation = XCTestExpectation(description: "Fetch posts with error")
        let useCase = MockPostsUseCase(posts: nil)
        useCase.getPosts() { (result) in
            switch result {
            case .success:
                XCTFail("Unexpected error")
            case .failure(let error):
                if let error = error as? MockPostsUseCaseError {
                    XCTAssertEqual(error, .generic)
                    expectation.fulfill()
                } else {
                    XCTFail("Unexpected error")
                }
            }
        }
    }
}

private extension PostsUseCaseTests {
    func getPosts() -> [Post] {
        let firstPost = Post(userID: 1,
                             ID: 1,
                             title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                             description: "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto",
                             isRead: true,
                             isFavorite: false)
        let secondPost = Post(userID: 1,
                              ID: 2,
                              title: "qui est esse",
                              description: "est rerum tempore vitae sequi sint nihil reprehenderit dolor beatae ea dolores neque fugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis qui aperiam non debitis possimus qui neque nisi nulla",
                              isRead: true,
                              isFavorite: true)
        return [firstPost, secondPost]
    }
}
