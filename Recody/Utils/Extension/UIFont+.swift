//
//  UIFont+.swift
//  Recody
//
//  Created by Glory Kim on 2022/11/29.
//

import Foundation
import UIKit
enum FontType {
    case regular, bold, medium, light, semibold
}
extension UIFont {
    static func fontWithName(type: FontType, size: CGFloat) -> UIFont {
        var fontName = ""
        switch type {
        case .regular:
            fontName = "AppleSDGothicNeo-Regular"
        case .light:
            fontName = "AppleSDGothicNeo-Light"
        case .medium:
            fontName = "AppleSDGothicNeo-Medium"
        case .semibold:
            fontName = "AppleSDGothicNeo-SemiBold"
        case .bold:
            fontName = "AppleSDGothicNeo-Bold"
        }
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
