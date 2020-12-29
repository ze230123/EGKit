//
//  CornerButton.swift
// 
//
//  Created by dev-02 on 2020/12/25.
//
//

import UIKit

/// 圆角Button
@IBDesignable
public class CornerButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var masksToBounds: Bool = false {
        didSet {
            layer.masksToBounds = masksToBounds
        }
    }

    @IBInspectable var numberOfLines: Int = 0 {
        didSet {
            titleLabel?.numberOfLines = numberOfLines
        }
    }
}
