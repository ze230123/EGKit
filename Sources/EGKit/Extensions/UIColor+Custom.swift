//
//  UIColor+Custom.swift
//  
//
//  Created by youzy01 on 2020/12/28.
//

import UIKit

public extension UIColor {
    /// 16进制颜色
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255
        let green = CGFloat((hex & 0xFF00) >> 8) / 255
        let blue = CGFloat(hex & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

