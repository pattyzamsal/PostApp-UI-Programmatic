//
//  BaseViewController.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation
import UIKit

typealias AlertAction = ((UIAlertAction) -> Void)?

class BaseViewController: UIViewController {
    
    private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            setNavigationBarColors()
        }
    }
    
    func setBackButton(title: String) {
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.topItem?.title = title
    }
    
    func setActivityIndicator(_ activityIndicator: UIActivityIndicatorView!) {
        self.activityIndicator = activityIndicator
    }
    
    func showLoading() {
        view.isUserInteractionEnabled = false
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        view.isUserInteractionEnabled = true
        activityIndicator.alpha = 0
        activityIndicator.stopAnimating()
    }
    
    func showAlertView(error: String, didTapActionButton: AlertAction) {
        let alert = UIAlertController(title: TextsConstants.occurAnError.rawValue,
                                      message: error,
                                      preferredStyle: .alert)
        let actionButton = UIAlertAction(title: TextsConstants.accept.rawValue,
                                         style: .default,
                                         handler: didTapActionButton)
        alert.addAction(actionButton)
        present(alert, animated: true, completion: nil)
    }
    
    func setNavigationBarColors() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.getColorApp(name: .blueLight)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
}
