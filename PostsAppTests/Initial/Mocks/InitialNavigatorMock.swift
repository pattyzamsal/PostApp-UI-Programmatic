//
//  InitialNavigatorMock.swift
//  PostsAppTests
//
//  Created by Patricia Zambrano on 11/10/21.
//

@testable import PostsAppSTGDebug

enum InitialNavigatorDestination {
    case postsList
}

final class InitialNavigatorMock: InitialNavigatorContract {
    var destination: InitialNavigatorDestination?
    
    func presentListPosts() {
        destination = .postsList
    }
}
