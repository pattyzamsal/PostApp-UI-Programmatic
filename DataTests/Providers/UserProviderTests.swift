//
//  UserProviderTests.swift
//  DataTests
//
//  Created by Patricia Zambrano on 9/10/21.
//

import XCTest
@testable import Data

final class UserProviderTests: XCTestCase {
    private var provider: MockUserProvider!
    private var data: Data!
    private var userEntity: UserEntity!
    private lazy var mockDataTests = DataTestsMock()
    
    override func setUp() {
        super.setUp()
        guard let url = mockDataTests.getLocalURLPathOfMockJSONBy(nameFile: "User"),
              let data = mockDataTests.convertURLToData(url: url),
              let user = try? JSONDecoder().decode(UserEntity.self, from: data) else {
            return
        }
        self.data = data
        self.userEntity = user
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUserParseSuccess() {
        let expectation = XCTestExpectation(description: "Parse user")
        guard let url = mockDataTests.getLocalURLPathOfMockJSONBy(nameFile: "User") else {
            XCTFail("Couldn't get json file")
            return
        }
        guard let data = mockDataTests.convertURLToData(url: url) else {
            XCTFail("Couldn't load data")
            return
        }
        do {
            let result = try JSONDecoder().decode(UserEntity.self, from: data)
            XCTAssertEqual(result.ID, 1)
            expectation.fulfill()
        } catch {
            XCTFail("Couldn't get object from data")
        }
    }
    
    func testGetUserWithSuccess() {
        let expectation = XCTestExpectation(description: "Fetch user")
        provider = MockUserProvider(result: .success(data))
        provider.getUserByID("1") { (result) in
            switch result {
            case .success(let user):
                let userModel = try? self.userEntity.toDomain()
                XCTAssertEqual(user.ID, userModel?.ID)
                XCTAssertEqual(user.name, userModel?.name)
                XCTAssertEqual(user.username, userModel?.username)
                XCTAssertEqual(user.email, userModel?.email)
                expectation.fulfill()
            case .failure:
                XCTFail("Unexpected error")
            }
        }
        wait(for: [expectation], timeout: 3)
        
    }
    
    func testGetUserWithError() {
        let expectation = XCTestExpectation(description: "Fetch user with error")
        let errorData = Data()
        provider = MockUserProvider(result: .success(errorData))
        provider.getUserByID("") { (result) in
            switch result {
            case .success:
                XCTFail("Unexpected error")
            case .failure(let error):
                if let error = error as? MockUserProviderContractError {
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
