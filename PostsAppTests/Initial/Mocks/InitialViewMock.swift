//
//  InitialViewMock.swift
//  PostsAppTests
//
//  Created by Patricia Zambrano on 11/10/21.
//

@testable import PostsAppSTGDebug

final class InitialViewMock: InitialViewContract {
    var state: InitialViewState?
    
    func renderViewState(_ state: InitialViewState) {
        self.state = state
    }
}
