//
//  PostDetailNavigator.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Foundation
import UIKit

final class PostDetailNavigator {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension PostDetailNavigator: PostDetailContract.Navigator {
    func presentPreviousView(post: PostViewModel) {
        let actualVC = viewController?.navigationController?.popViewController(animated: true)
        if let vc = actualVC,
           let navController = vc.navigationController,
           let previousVC = navController.viewControllers.last,
           let postsListVC = previousVC as? PostsListViewController {
            postsListVC.reloadView(post: post)
        }
    }
}

