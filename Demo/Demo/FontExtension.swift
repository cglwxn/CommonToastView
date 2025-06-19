//
//  FontExtension.swift
//  MemeShot
//
//  Created by cc on 2024/10/21.
//

import UIKit

enum FontSize: CGFloat {
    case main = 12.0
    case miniContent = 8.0
    case alertContent = 10.0
    case littleTitle = 11.0
    case littleContent = 13.0
    case content = 14.0
    case mediumContent = 15.0
    case bigTitle = 16.0
    case biggerTitle = 17.0
    case bigContent = 18.0
    case biggerContent = 19.0
    case boldContent = 20.0
    case hugeTitle = 22.0
    case hugerTitle = 23.0
    case hugeContent = 25.0
    case largeTitle = 26.0
    case largeContent = 28.0
    case superContent = 30.0
}

enum FontWeight: String {
    case Regular
    case Ultralight
    case Light
    case Thin
    case Medium
    case Semibold
    case Bold
}

enum FontFamily: String {
    case System
    case PingFangSC
    case PingFangTC
}


extension UIFont {
    class func font(
        size: FontSize,
        family: FontFamily = .PingFangSC,
        weight: FontWeight = .Regular
    ) -> UIFont {
        if family == .System {
            if weight == .Regular {
                return UIFont.systemFont(ofSize: size.rawValue)
            } else {
                return UIFont.boldSystemFont(ofSize: size.rawValue)
            }
        }

        return UIFont(
            name: family.rawValue + "-" + weight.rawValue,
            size: size.rawValue)
        ?? UIFont.font(size: size, family: .System, weight: weight)
    }
}
