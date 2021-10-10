//
//  InitialViewController.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation
import UIKit

class InitialViewController: BaseViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var startButton: UIButton!
    
    private lazy var presenter: InitialContract.Presenter = {
        let navigator = InitialNavigator(viewController: self)
        return InitialPresenter(view: self,
                                navigator: navigator)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func didTapStartButton(_ sender: Any) {
        presenter.didTapStartButton()
    }
}

private extension InitialViewController {
    func setupView() {
        titleLabel.text = TextsConstants.initialTitle.rawValue
        descriptionLabel.text = TextsConstants.descriptionApp.rawValue
        startButton.setTitle(TextsConstants.startButtonTitle.rawValue, for: .normal)
    }
}

extension InitialViewController: InitialContract.View {
    func renderViewState(_ state: InitialViewState) {
        switch state {
        case .clear:
            break
        }
    }
}
