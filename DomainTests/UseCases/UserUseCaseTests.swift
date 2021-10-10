//
//  UserUseCaseTests.swift
//  DomainTests
//
//  Created by Patricia Zambrano on 10/10/21.
//

@testable import Domain
import XCTest

final class UserUseCaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetUserUseCaseWithSuccess() {
        let expectation = XCTestExpectation(description: "Fetch user")
        let userTest = getUser()
        let useCase = MockUserUseCase(user: userTest)
        useCase.getUserByID("1") { (result) in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.ID, userTest.ID)
                XCTAssertEqual(user.name, userTest.name)
                XCTAssertEqual(user.username, userTest.username)
                XCTAssertEqual(user.email, userTest.email)
                XCTAssertEqual(user.phone, userTest.phone)
                XCTAssertEqual(user.website, userTest.website)
                expectation.fulfill()
            case .failure:
                XCTFail("Unexpected error")
            }
        }
    }
    
    func testGetUserUseCaseWithError() {
        let expectation = XCTestExpectation(description: "Fetch user with error")
        let useCase = MockUserUseCase(user: nil)
        useCase.getUserByID("") { (result) in
            switch result {
            case .success:
                XCTFail("Unexpected error")
            case .failure(let error):
                if let error = error as? MockUserUseCaseError {
                    XCTAssertEqual(error, .generic)
                    expectation.fulfill()
                } else {
                    XCTFail("Unexpected error")
                }
            }
        }
    }
}

private extension UserUseCaseTests {
    func getUser() -> User {
        let geoLocation = Coordinates(latitude: "-37.3159",
                                      longitude: "81.1496")
        let address = Address(street: "Kulas Light",
                              suite: "Apt. 556",
                              city: "Gwenborough",
                              zipcode: "92998-3874",
                              geoLocation: geoLocation)
        let company = Company(name: "Romaguera-Crona",
                              catchPhrase: "Multi-layered client-server neural-net",
                              bs: "harness real-time e-markets")
        return User(ID: 1,
                    name: "Leanne Graham",
                    username: "Bret",
                    email: "Sincere@april.biz",
                    phone: "1-770-736-8031 x56442",
                    website: "hildegard.org",
                    address: address,
                    company: company)
    }
}
