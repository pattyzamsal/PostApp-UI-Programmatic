//
//  PostTableViewCell.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var arrowImageView: UIImageView!
    
    private var post: PostViewModel?
    
    static let identifier = "PostTableViewCell"
    
    static func registerCellForTable(_ tableView: UITableView) {
        let nib = UINib(nibName: identifier,
                        bundle: Bundle(for: PostTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .gray
    }
    
    func fill(post: PostViewModel) {
        self.post = post
        setupCell()
    }
}

private extension PostTableViewCell {
    func setupCell() {
        guard let viewModel = post else {
            titleLabel.text = ""
            iconImageView.isHidden = true
            arrowImageView.isHidden = true
            return
        }
        titleLabel.text = viewModel.title
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
