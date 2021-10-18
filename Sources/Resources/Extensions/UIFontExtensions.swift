//
//  UIFontExtensions.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 18/10/21.
//

import Foundation
import UIKit

enum StyleFont: String {
    case bold = "-Bold"
    case demiBold = "-DemiBold"
    case heavy = "-Heavy"
    case regular = "-Regular"
}

enum SizeFont: CGFloat {
    case big = 30.0
    case large = 20.0
    case medium = 18.0
    case small = 16.0
    case tiny = 14.0
}

extension UIFont {
    static func getFontApp(style: StyleFont, size: SizeFont) -> UIFont? {
        let familyName = "AvenirNext"
        let name = "\(familyName)\(style.rawValue)"
        return UIFont(name: name, size: size.rawValue)
    }
}
