//
//  InitialNavigator.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import UIKit

final class InitialNavigator {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension InitialNavigator: InitialContract.Navigator {
    func presentListPosts() {
        let postsListVC = PostsListViewController()
        viewController?.navigationController?.pushViewController(postsListVC, animated: true)
    }
}
