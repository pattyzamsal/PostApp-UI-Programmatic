//
//  CommentTableViewCell.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import UIKit

final class CommentTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let titleLabel = PostLabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.assignBoldStyle()
        return titleLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = PostLabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.assignRegularStyle()
        return descriptionLabel
    }()
    
    private let autorLabel: UILabel = {
        let autorLabel = PostLabel()
        autorLabel.translatesAutoresizingMaskIntoConstraints = false
        autorLabel.assignDemiBoldStyle()
        return autorLabel
    }()
    
    private var comment: CommentViewModel?
    
    static let identifier = "CommentTableViewCell"
    
    static func registerCellForTable(_ tableView: UITableView) {
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(comment: CommentViewModel) {
        self.comment = comment
        setupCell()
    }
}

private extension CommentTableViewCell {
    func createViews() {
        selectionStyle = .none
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(autorLabel)
        addConstraintsForViews()
    }
    
    func addConstraintsForViews() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            autorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            autorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            autorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: autorLabel.bottomAnchor, constant: 10)
        ])
    }
    
    func setupCell() {
        guard let viewModel = comment else {
            titleLabel.isHidden = true
            descriptionLabel.isHidden = true
            autorLabel.isHidden = true
            return
        }
        titleLabel.text = viewModel.commentTitle
        descriptionLabel.text = viewModel.commentDescription
        autorLabel.text = viewModel.commentByPerson
    }
}
