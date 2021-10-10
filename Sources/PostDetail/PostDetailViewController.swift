//
//  PostDetailViewController.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import UIKit

class PostDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBackButton(title: TextsConstants.backTitle.rawValue)
        setRightBarButton()
        title = TextsConstants.postDetail.rawValue
    }
}

private extension PostDetailViewController {
    func setRightBarButton() {
        let item = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(didTapFavorite))
        setRightButtonWithItem(item)
    }
    
    @objc func didTapFavorite() {
        print("didTapFavorite")
    }
}
