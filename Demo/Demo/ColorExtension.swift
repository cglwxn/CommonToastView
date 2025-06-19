//
//  MSColor.swift
//  MemeShot
//
//  Created by cc on 2024/10/21.
//

import UIKit

enum MSColor: Int {
    ///0x20E36E
    case mainColor = 0x3cc06b
    ///0xF14A3E
    case redColor = 0xF14A3E
    ///0xEBEBEB
    case bordrColor = 0xEBEBEB
    ///0xC1C1C1
    case placeholderColor = 0xC1C1C1
    ///0xA4A7A9
    case unselectedColor = 0xA4A7A9
    ///0x0E131A
    case selectedColor = 0x0E131A
    ///0x3295F6
    case sliderColor = 0x3295F6
    ///0x273446
    case emptyLabelColor = 0x273446
    ///0x223848
    case titleColor = 0x223848
    ///0xF7F7F7
    case lightGrayBackgroundColor = 0xF7F7F7
    ///0xF0F0F0
    case lightGrayBackgroundColor1 = 0xF0F0F0
    ///0x85868A
    case grayContentColor = 0x85868A
    ///0xFAF8F8
    case grayBackgrondColor = 0xFAF8F8
    ///grayBackgroundColor
    case grayBackgroundColor = 0xF2F2F2
    ///0x2F2F2F
    case darkBackgroundColor = 0x2F2F2F
    ///0x000000
    case black = 0x000000
    ///0xE5E5E5
    case lightGray = 0xE5E5E5
    ///0xEAEAEA
    case lightGray1 = 0xEAEAEA
    ///0xE8DFCD
    case lightYello = 0xE8DFCD
    ///0x0F1F1F
    case darkModeBackgroundColor = 0x0F1F1F
    ///0xC65255
    case lightRedColor = 0xFFF5F7
    ///0xB2B2B2
    case lightTextColor = 0xB2B2B2
    ///0x929292
    case darkTextColor = 0x929292
    ///0xF1F1F1
    case lightLineColor = 0xF1F1F1
    ///0x999999
    case lightGrayTitleColor = 0x999999
    ///0xD2F4DE
    case lightGreenBackgroundColor = 0xD2F4DE
    ///0xFC5A36
    case orangeRedColor = 0xFC5A36
    ///0x28E35C
    case lightBlue = 0x28E35C
    ///0xC544D2
    case solonaPurple = 0xC544D2
    ///0xFCF0E4
    case msftCpColor = 0xFCF0E4
    ///0xA1FF22
    case rewardGreenColor = 0xA1FF22
    ///0x101016
    case rewardBackgroundColor = 0x101016
}

extension UIColor {
    class func color(
        _ msColor: MSColor,
        alpha: Float = 1.0
    ) -> UIColor {
        return UIColor.colorFromHexValue(UInt(msColor.rawValue), alpha: alpha)
    }
    
    class func colorFromHexValue(
        _ hex: UInt,
        alpha: Float = 1.0
    ) -> UIColor {
        return UIColor(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
