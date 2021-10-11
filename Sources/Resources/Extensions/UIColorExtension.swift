//
//  UIColorExtension.swift
//  PostsApp
//
//  Created by Patricia Zambrano on 10/10/21.
//

import Foundation
import UIKit

enum AssetColor {
    case blueLight
    case yellowForStar
}

extension UIColor {
    static func getColorApp(name: AssetColor) -> UIColor? {
        switch name {
        case .blueLight:
            return UIColor(named: "blueLight")
        case .yellowForStar:
            return UIColor(named: "yellowForStar")
        }
    }
}
