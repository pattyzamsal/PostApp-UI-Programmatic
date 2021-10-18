//
//  PostLabel.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 18/10/21.
//

import Foundation
import UIKit

enum TypeLabel {
    case title
    case description
}

final class PostLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func setupText(_ text: String) {
        self.text = text
    }
    
    func assignStyleInInitialView(type: TypeLabel) {
        setupColor(.white)
        setupAlignment(.center)
        switch type {
        case .title:
            setupFont(style: .bold, size: .big)
        case .description:
            setupFont(style: .demiBold, size: .tiny)
        }
    }
    
    func assignStyleInEmptyView() {
        setupColor(.black)
        setupAlignment(.center)
        setupFont(style: .demiBold, size: .big)
    }
    
    func assignStylePostCell() {
        setupColor(.black)
        setupAlignment(.left)
        setupFont(style: .regular, size: .tiny)
    }
}


private extension PostLabel {
    func commonInit() {
        numberOfLines = 0
        lineBreakMode = .byTruncatingTail
    }
    
    func setupColor(_ color: UIColor) {
        textColor = color
    }
    
    func setupFont(style: StyleFont, size: SizeFont) {
        font = UIFont.getFontApp(style: style, size: size)
    }
    
    func setupAlignment(_ alignment: NSTextAlignment) {
        textAlignment = alignment
    }
}
