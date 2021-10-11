//
//  CommentTableViewCell.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var autorLabel: UILabel!
    
    private var comment: CommentViewModel?
    
    static let identifier = "CommentTableViewCell"
    
    static func registerCellForTable(_ tableView: UITableView) {
        let nib = UINib(nibName: identifier,
                        bundle: Bundle(for: CommentTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func fill(comment: CommentViewModel) {
        self.comment = comment
        setupCell()
    }
}

private extension CommentTableViewCell {
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
