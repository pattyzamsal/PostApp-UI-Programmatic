//
//  InitialViewController.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 9/10/21.
//

import Foundation
import UIKit

class InitialViewController: BaseViewController {
    private let titleLabel: UILabel = {
        let titleLabel = PostLabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.assignStyleInInitialView(type: .title)
        return titleLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = PostLabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.assignStyleInInitialView(type: .description)
        return descriptionLabel
    }()
    
    private var stackView: UIStackView!
    
    private let startButton: UIButton = {
        let startButton = UIButton(type: .custom)
        startButton.titleLabel?.font = UIFont.getFontApp(style: .heavy, size: .medium)
        startButton.backgroundColor = .clear
        startButton.translatesAutoresizingMaskIntoConstraints = false
        return startButton
    }()
    
    private lazy var presenter: InitialContract.Presenter = {
        let navigator = InitialNavigator(viewController: self)
        return InitialPresenter(view: self,
                                navigator: navigator)
    }()
    
    override func loadView() {
        super.loadView()
        createViews()
    }
    
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
    
    @objc func didTapStartButton(_ sender: Any) {
        presenter.didTapStartButton()
    }
}

private extension InitialViewController {
    func createViews() {
        view.backgroundColor = UIColor.getColorApp(name: .blueLight)
        createStackView()
        view.addSubview(stackView)
        view.addSubview(startButton)
        addConstraintsForViews()
    }
    
    func createStackView() {
        let views = [titleLabel, descriptionLabel]
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView = stackView
    }
    
    func addConstraintsForViews() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 0.9),
            
            startButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupView() {
        titleLabel.text = TextsConstants.initialTitle.rawValue
        descriptionLabel.text = TextsConstants.descriptionApp.rawValue
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
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
