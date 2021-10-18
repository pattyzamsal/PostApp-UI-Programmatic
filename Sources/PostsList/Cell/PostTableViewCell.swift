//
//  PostTableViewCell.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    private let titleLabel: PostLabel = {
        let titleLabel = PostLabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.assignRegularStyle()
        return titleLabel
    }()
    
    private let iconImageView: UIImageView = {
       let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    private let arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        arrowImageView.tintColor = UIColor.getColorApp(name: .blueLight)
        return arrowImageView
    }()
    
    private var post: PostViewModel?
    
    static let identifier = "PostTableViewCell"
    
    static func registerCellForTable(_ tableView: UITableView) {
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(post: PostViewModel) {
        self.post = post
        setupCell()
    }
}

private extension PostTableViewCell {
    func createViews() {
        self.selectionStyle = .gray
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(arrowImageView)
        addConstraintsForViews()
    }
    
    func addConstraintsForViews() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor, multiplier: 1/1),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            arrowImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalTo: arrowImageView.widthAnchor, multiplier: 1/1),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
            ])
    }
    
    func setupCell() {
        guard let viewModel = post else {
            titleLabel.setupText("")
            iconImageView.isHidden = true
            arrowImageView.isHidden = true
            return
        }
        titleLabel.setupText(viewModel.title)
        arrowImageView.isHidden = false
        setIconImage(viewModel: viewModel)
    }
    
    func setIconImage(viewModel: PostViewModel) {
        if !viewModel.isRead {
            iconImageView.image = UIImage(systemName: "dot.circle.fill")?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = UIColor.getColorApp(name: .blueLight)
            iconImageView.isHidden = false
            return
        }
        if viewModel.isFavorite {
            iconImageView.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = UIColor.getColorApp(name: .yellowForStar)
            iconImageView.isHidden = false
            return
        }
        iconImageView.isHidden = true
    }
}
