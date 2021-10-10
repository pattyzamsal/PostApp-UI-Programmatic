//
//  PostsInjector.swift
//  Injector
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Data
import Domain
import Foundation

public class PostsInjector {
    public static func providePostsUseCase() -> PostsUseCaseContract {
        return PostsUseCase(provider: PostsProvider())
    }
    
    public static func provideCommentsUseCase() -> CommentsUseCaseContract {
        return CommentsUseCase(provider: CommentsProvider())
    }
    
    public static func provideUserUseCase() -> UserUseCaseContract {
        return UserUseCase(provider: UserProvider())
    }
}
