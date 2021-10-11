//
//  InitialPresenterTests.swift
//  PostsAppTests
//
//  Created by Patricia Zambrano on 11/10/21.
//

import XCTest
@testable import PostsAppSTGDebug

final class InitialPresenterTests: XCTestCase {
    var mockView: InitialViewMock!
    var navigator: InitialNavigatorMock!
    
    override func setUp() {
        super.setUp()
        mockView = InitialViewMock()
        navigator = InitialNavigatorMock()
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        navigator = nil
    }
    
    func testDidTapOnStartButton() {
        let presenter = InitialPresenter(view: mockView,
                                         navigator: navigator)
        presenter.didTapStartButton()
        XCTAssertEqual(navigator.destination, .postsList)
    }
}
