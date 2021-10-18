//
//  EmptyView.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import UIKit

final class EmptyView: UIView {
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        return contentView
    }()
    
    private let descriptionLabel: PostLabel = {
        let descriptionLabel = PostLabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.assignStyleInEmptyView()
        return descriptionLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func fill(description: String) {
        descriptionLabel.setupText(description)
    }
}

private extension EmptyView {
    func setupView() {
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        contentView.addSubview(descriptionLabel)
        addConstraintsForLabel()
    }
    
    func addConstraintsForLabel() {
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 20.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -20.0),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
}
